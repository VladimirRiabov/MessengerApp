//
//  ChatView.swift
//  MessengerApp
//
//  Created by Владимир Рябов on 17.01.2022.
//

import SwiftUI

struct CustomField: ViewModifier {
    
    
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background(RoundedRectangle(cornerRadius: 5).fill(Color(.secondarySystemBackground)))
            .foregroundColor(.white)
            .padding(.leading, 5)
        
    }
}

struct ChatView: View {
    @EnvironmentObject var model: AppStateModel
    @State private var message: String = ""
    
    let otherUsername: String
    init(otherUsername: String) {
        self.otherUsername = otherUsername
    }
    
    var body: some View {
        VStack {
            ScrollView(.vertical) {
                ForEach(model.messages, id: \.self) { message in
                    ChatRow(text: "Hellow world", type: .sent)
                        .padding(3)
                }
            }
            HStack {
                TextField("Message...", text: $message)
                    .modifier(CustomField())
                
                SendButton(text: $message)

            }
        }
        .navigationTitle(otherUsername)
        .onAppear {
            model.otherUsername = otherUsername
            model.observeChat()
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(otherUsername: "Samantha")
            .preferredColorScheme(.dark)
    }
}
