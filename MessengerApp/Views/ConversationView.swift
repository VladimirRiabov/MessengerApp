//
//  ConversationView.swift
//  MessengerApp
//
//  Created by Владимир Рябов on 17.01.2022.
//

import SwiftUI

struct ConversationListView: View {
    let usernames = ["Joe", "Jill", "Bob"]
    
    @EnvironmentObject var model: AppStateModel
    @State private var otherUsername: String = ""
    @State private var showChat = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(usernames, id: \.self) { name in
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
                            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                                self.otherUsername = name
                                self.showChat = true
                            }
                            
                        },
                        label: {
                            Image(systemName: "magnifyingglass")
                        })
                }
                
                
            }
            
            .fullScreenCover(isPresented: $model.showingSignIn , content: {
                SignInView()
            })
        }
        
        
    }
    func signOut() {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationListView()
            .preferredColorScheme(.dark)
    }
}

