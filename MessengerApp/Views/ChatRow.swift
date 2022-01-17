//
//  ChatRow.swift
//  MessengerApp
//
//  Created by Владимир Рябов on 17.01.2022.
//

import SwiftUI

struct ChatRow: View {
    let type: MessageType
    let text: String
    
    var isSender: Bool {
        return type == .sent
    }
   
    init(text: String ,type: MessageType) {
        self.text = text
        self.type = type
    }
    
    var body: some View {
        HStack {
            if isSender {Spacer() }
            
            if !isSender {
                VStack {
                    
                    Spacer()
                    Circle()
                        .foregroundColor(.pink)
                        .frame(width: 45, height: 45)
                    
                }
                    
            }
            
            HStack {
                Text(text)
                    .foregroundColor(.white)
                    .padding()
            }
            .background(isSender ? .blue : Color(.systemGray4))
            .cornerRadius(10)
            .padding(isSender ? .leading : .trailing, UIScreen.main.bounds.width / 4)
            
            
            if !isSender {Spacer() }
        }
    }
}

struct ChatRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ChatRow(text: "Test", type: .sent)
                .preferredColorScheme(.dark)
            ChatRow(text: "Test", type: .received)
                .preferredColorScheme(.dark)
        }
        
    }
}
