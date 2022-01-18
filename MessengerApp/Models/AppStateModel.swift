//
//  AppStateModel.swift
//  MessengerApp
//
//  Created by Владимир Рябов on 17.01.2022.
//

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseFirestore



class AppStateModel: ObservableObject {
    //is user isgned in then open ? signiinscreen : conversationview
    @Published var showingSignIn: Bool = true
    //current user being chatted with
    //messages conversations
    
    @AppStorage("currentUsername") var currentUsername: String = ""
    @AppStorage("currentEmail") var currentEmail: String = ""
    
    @Published var conversations: [String] = []
    @Published var messages: [Message] = []
    var otherUsername = ""
    
    let database = Firestore.firestore()
    let auth = Auth.auth()
    
    var conversationListener: ListenerRegistration?
    var chatListener: ListenerRegistration?
    
    init() {
        self.showingSignIn = Auth.auth().currentUser == nil
    }
    
}

//Search
extension AppStateModel {
    func searchUsers(queryText: String, completion: @escaping ([String]) -> Void) {
        database.collection("users").getDocuments { snapshot, error in
            guard let usernames = snapshot?.documents.compactMap({$0.documentID}),
                  error == nil else {
                      completion([])
                      return
                  }
            let filtered = usernames.filter({$0.lowercased().hasPrefix(queryText.lowercased())
                
            })
            completion(filtered)
        }
         
    }
}

//Conversation
extension AppStateModel {
    func getConversations() {
        //listen for conversations
        //every time new chat added to database this block will be called
        conversationListener = database
            .collection("users")
            .document(currentUsername)
            .collection("chats").addSnapshotListener({[weak self] snapshot, error in
                guard let usernames = snapshot?.documents.compactMap({$0.documentID}), error == nil else {
                    return
                }
                
                DispatchQueue.main.async {
                    self?.conversations = usernames
                }
                
            })
    }
}

//Get Chat and sent Messages
extension AppStateModel {
    func observeChat() {
            createConversation()

            chatListener = database
                .collection("users")
                .document(currentUsername)
                .collection("chats")
                .document(otherUsername)
                .collection("messages")
                .addSnapshotListener { [weak self] snapshot, error in
                    guard let objects = snapshot?.documents.compactMap({ $0.data() }),
                          error == nil else {
                        return
                    }

                    let messages: [Message] = objects.compactMap({
//                        guard let date = ISO8601DateFormatter().date(from: $0["created"] as? String ?? "") else {
//                            return nil
//                        }
                        return Message(
                            text: $0["text"] as? String ?? "",
                            type: $0["sender"] as? String == self?.currentUsername ? .sent : .received,
                            created: DateFormatter().date(from: $0["created"] as? String ?? "") ?? Date())
//                            type: $0["sender"] as? String == self?.currentUsername ? .sent : .received,
//                            created: date
                        
                    })
//                        .sorted(by: { first, second in
//                        return first.created < second.created
//                    })
                    

                    DispatchQueue.main.async {
                        self?.messages = messages
                    }
                }
        }
    
    func sendMessage(text: String) {
        
    }
    func createConversation() {
        database.collection("users")
            .document(currentUsername)
            .collection("chats")
            .document(otherUsername).setData(["created":"true"])
        
        database.collection("users")
            .document(otherUsername)
            .collection("chats")
            .document(currentUsername).setData(["created":"true"])
    }
}

//Sign In Sign Up users
extension AppStateModel {
    func signIn(username: String, password: String) {
        
        //getting email
        database.collection("users").document(username).getDocument {[weak self] snapshot, error in
            guard let email = snapshot?.data()?["email"] as? String, error == nil else {
                return
            }
            // Try to sign in
            self?.auth.signIn(withEmail: email, password: password, completion: { result, error in
                guard error == nil, result != nil else {
                    return
                }
                DispatchQueue.main.async {
                    self?.currentUsername = username
                    self?.currentEmail = email
                    
                    self?.showingSignIn = false
                }
            })
            
        }
        
    }
    
    func signUp(email: String, username: String, password: String) {
        // Create an Account
        auth.createUser(withEmail: email, password: password) {[weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            
            let data = [
                "email" : email,
                "username" : username
            ]
            self?.database.collection("users")
                .document(username)
                .setData(data) { error in
                    guard error == nil else {
                        return
                    }
                    DispatchQueue.main.async {
                        self?.currentUsername = username
                        self?.currentEmail = email
                        
                        self?.showingSignIn = false
                    }
                    
                }
            
        }
        
    }
    
    func signOut() {
        do {
            try auth.signOut()
            self.showingSignIn = true
        } catch {
            print(error)
        }
    }
}

