//
//  SendButton.swift
//  MessengerApp
//
//  Created by Владимир Рябов on 17.01.2022.
//

import SwiftUI

struct SendButton: View {
    
    @EnvironmentObject var model: AppStateModel
    @Binding var text: String
//    @EnvironmentObject var model: AppStateModel
    var body: some View {
        Button {
            self.sendMessage()
        } label: {
            Image(systemName: "paperplane")
                .font(.system(size: 25))
                .aspectRatio(contentMode: .fit)
                .frame(width: 55, height: 55)
                .foregroundColor(.white)
                .background(.blue)
                .clipShape(Circle())
        }
    }
    func sendMessage() {
        guard !text.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        
        model.sendMessage(text: text)
        
        text = ""
        
    }
}


