//
//  ConversationView.swift
//  MessengerApp
//
//  Created by Владимир Рябов on 17.01.2022.
//

import SwiftUI

struct ConversationListView: View {
        
    @EnvironmentObject var model: AppStateModel
    @State private var otherUsername: String = ""
    @State private var showChat = false
    @State var showSearch = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(model.conversations, id: \.self) { name in
                    NavigationLink(
                        destination: ChatView(otherUsername: name),
                        label: {
                            HStack {
                                Circle()
                                    .frame(width: 65, height: 65)
                                    .foregroundColor(Color.pink)
                                
                                Text(name)
                                    .foregroundColor(.white)
                                    .bold()
                                    .font(.title2)
                                Spacer()
                            }
                            .padding()
                            
                        })
                }
                if !otherUsername.isEmpty {
                    NavigationLink("", destination: ChatView(otherUsername: otherUsername), isActive: $showChat)
                }
            }
            .navigationTitle("Chats")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("SignOut") {
                        self.signOut()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    //show search view
                    NavigationLink(
                        destination: SearchView() {name in
                            self.showSearch = false
                            
                            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                                self.otherUsername = name
                                self.showChat = true
                            }
                            
                        },
                        isActive: $showSearch,
                        label: {
                            Image(systemName: "magnifyingglass")
                        })
                }
                
                
            }
            
            .fullScreenCover(isPresented: $model.showingSignIn , content: {
                SignInView()
            })
            .onAppear {
                guard model.auth.currentUser != nil else {
                    return
                }
                model.getConversations()
            }
        }
        
        
    }
    func signOut() {
        model.signOut()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationListView()
            .preferredColorScheme(.dark)
    }
}

