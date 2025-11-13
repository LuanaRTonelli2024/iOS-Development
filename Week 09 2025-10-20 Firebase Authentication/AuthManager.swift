//
//  AuthManager.swift
//  Firebase Example
//
//  Created by user285344 on 11/7/25.
//

import Foundation
import Combine
import FirebaseAuth

class AuthManager: ObservableObject {
    
    @Published var user: User? // User -> FirebaseAuth.User
    
    init() {
        self.user = Auth.auth().currentUser
    }
    
    // register
    // email, password
    func register(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void){
        
        //@escaping makes yhis func async
        // Result --> user or error
        Auth.auth().createUser(withEmail: email, password: password) {result, error in
            if let error = error {
                completion(.failure(error))
            }
            else if let user = result?.user{
                self.user = user
                completion(.success(user))
            }
        }
    }
    
    //login
    func login(email: String, passowrd: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password:passowrd) { result, error in
            if let error = error {
                completion(.failure(error))
            }
            else if let user = result?.user {
                self.user = user
                completion(.success(user))
            }
        }
    }
    
    //logout/signout
    func logout(){
        do {
            try Auth.auth().signOut()
            self.user = nil
        }
        catch {
            print("Error Signing out: \(error.localizedDescription)")
        }
    }
}

