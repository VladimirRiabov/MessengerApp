//
//  AppStateModel.swift
//  MessengerApp
//
//  Created by Владимир Рябов on 17.01.2022.
//

import Foundation
import SwiftUI



class AppStateModel: ObservableObject {
    //is user isgned in then open ? signiinscreen : conversationview
    @Published var showingSignIn: Bool = true
    //current user being chatted with
    //messages conversations
    
    @AppStorage("currentUsername") var currentUsername: String = ""
    @AppStorage("currentEmail") var currentEmail: String = ""
    
    @Published var conversations: [String] = []
    @Published var messages: [Message] = []
    var otherUser = ""
    
}

//Search
extension AppStateModel {
    func searchUsers(queryText: String, completion: @escaping ([String]) -> Void) {
        
    }
}

//Conversation
extension AppStateModel {
    func getConversations() {
        //listen for conversations
    }
}

//Get Chat and sent Messages
extension AppStateModel {
    func observeChat() {
        
    }
    
    func sendMessage(text: String) {
        
    }
    func createConversationIfNeeded() {
        
    }
}

//Sign In Sign Up users
extension AppStateModel {
    func signIn(username: String, password: String) {
        // Try to sign in
    }
    
    func signUp(email: String, username: String, password: String) {
        // Try to sign in
    }
}

