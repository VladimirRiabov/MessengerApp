//
//  SignUpView.swift
//  MessengerApp
//
//  Created by Владимир Рябов on 17.01.2022.
//

import SwiftUI

struct SignUpView: View {
    @State var username: String = ""
    @State var email: String = ""
    @State var password: String = ""
    
    @EnvironmentObject var model: AppStateModel
    
    var body: some View {
            VStack {
                //heading
                Spacer()
                Spacer()
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                Text("Messenger")
                    .bold()
                    .font(.largeTitle)
              
                Spacer()
                //textfields
                VStack {
                    TextField("Email Address", text: $email)
                        .modifier(CustomField())
                    TextField("Username", text: $username)
                        .modifier(CustomField())
                    SecureField("Password", text: $password)
                        .modifier(CustomField())
                    Button(action: {
                        self.signUp()
                    }, label: {
                        Text("Sign Up")
                            .foregroundColor(.white)
                            .frame(width: 220, height: 50)
                            .background(.green)
                            .cornerRadius(6)
                    })
                }
                .padding()
                Spacer()
                Spacer()
                Spacer()
                
                
                
                
            }
            .navigationTitle("Create Account")
            .navigationBarTitleDisplayMode(.inline)
            .foregroundColor(.white)
    }
    func signUp() {
        guard !username.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              password.count >= 6 else {
                  return
              }
                
       
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
