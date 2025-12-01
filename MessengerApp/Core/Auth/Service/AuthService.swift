//
//  AuthService.swift
//  MessengerApp
//
//  Created by Родион Холодов on 01.12.2025.
//

import Foundation
import FirebaseAuth

class AuthService {
    static let shared = AuthService()
    
    func loginUser(email: String, password: String) {
        print("login user with: \(email) \(password)")
    }
    
    func createUser(email: String, fullname: String, password: String) async throws {
        print("create user with: \(email) \(fullname) \(password)")
        
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            print(result.user.uid)
        } catch {
            print(error.localizedDescription)
        }
    }
}
