//
//  SendButton.swift
//  MessengerApp
//
//  Created by Владимир Рябов on 17.01.2022.
//

import SwiftUI

struct SendButton: View {
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
        guard !text.isEmpty else {
            return
        }
    }
}

//struct SendButton_Previews: PreviewProvider {
//    @Binding var text: String
//    static var previews: some View {
//        SendButton(text: Binding<St)
//    }
//}

