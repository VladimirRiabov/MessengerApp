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
    
    @State private var message: String = ""
    
    let otherUsername: String
    init(otherUsername: String) {
        self.otherUsername = otherUsername
    }
    
    var body: some View {
        VStack {
            ScrollView(.vertical) {
                ChatRow(text: "Hello World", type: .sent)
                    .padding(5)
                ChatRow(text: "Hello World", type: .received)
                    .padding(5)
            }
            HStack {
                TextField("Message...", text: $message)
                    .modifier(CustomField())
                
                SendButton(text: $message)

            }
        }
        .navigationTitle(otherUsername)
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(otherUsername: "Samantha")
            .preferredColorScheme(.dark)
    }
}
