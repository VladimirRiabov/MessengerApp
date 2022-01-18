//
//  SignInView.swift
//  MessengerApp
//
//  Created by Владимир Рябов on 17.01.2022.
//

import SwiftUI

struct SignInView: View {
    @State var username: String = ""
    @State var password: String = ""
    
    @EnvironmentObject var model: AppStateModel
    
    var body: some View {
        NavigationView{
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
                    TextField("Username", text: $username)
                        .modifier(CustomField())
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    SecureField("Password", text: $password)
                        .modifier(CustomField())
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    Button(action: {
                        self.signIn()
                    }, label: {
                        Text("Sign In")
                            .foregroundColor(.white)
                            .frame(width: 220, height: 50)
                            .background(.blue)
                            .cornerRadius(6)
                    })
                }
                .padding()
                Spacer()
                Spacer()
                Spacer()
                
                //signup
                HStack {
                    Text("New to Messenger?")
                    NavigationLink("Create Account", destination: SignUpView())
                }
                
                
            }
        }
        
        
        
        
    }
    func signIn() {
        guard !username.trimmingCharacters(in: .whitespaces).isEmpty,
              !username.trimmingCharacters(in: .whitespaces).isEmpty,
              password.count >= 6 else {
                  return
              }
                
        model.signIn(username: username, password: password)
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
