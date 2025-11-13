//
//  RegisterView.swift
//  Firebase Example
//
//  Created by user285344 on 11/7/25.
//

import SwiftUI

struct RegisterView: View {
    
    @State private var email = ""
    @State private var passowrd = ""
    @EnvironmentObject var authManager: AuthManager
    @State private var errorMessage: String?
    
    var body: some View {
        VStack{
            TextField("Enter Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
            
            SecureField("Enter password", text: $passowrd)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
            
            // error message if I have any
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundStyle(.red)
                    .font(.caption)
            }
            
            Button("Register") {
                
                if email.isEmpty && passowrd.isEmpty {
                    self.errorMessage = "enter both email and password"
                    return
                }
                
                authManager.register(email: email, password: passowrd){
                    result in switch result {
                    case .success:
                        print("Registration Successfull")
                    case .failure(let error):
                        self.errorMessage = error.localizedDescription
                    }
                }
            }
            
            NavigationLink(destination: LoginView()){
                Text("Login here!")
            }
        }
        .padding()
    }
}

#Preview {
    RegisterView()
}
