//
//  SearchView.swift
//  MessengerApp
//
//  Created by Владимир Рябов on 17.01.2022.
//

import SwiftUI

struct SearchView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var text: String = ""
    let usernames = ["Julia"]
    let completion: ((String) -> Void)
    init(completion: @escaping ((String) -> Void)) {
        self.completion = completion
    }
    
    var body: some View {
        VStack {
            TextField("Username...", text: $text)
                .modifier(CustomField())
            Button("Search") {
                
            }
            List {
                ForEach(usernames, id: \.self) {name in
                    HStack {
                        Circle()
                            .frame(width: 55, height: 55)
                            .foregroundColor(.green)
                        Text(name)
                            .font(.headline)
                        Spacer()
                    }
                    .onTapGesture {
                        presentationMode.wrappedValue.dismiss()
                        completion(name)
                    }
                }
            }
            Spacer()
        }
        .navigationTitle("Search")
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView() {_ in}
            .preferredColorScheme(.dark)
    }
}
