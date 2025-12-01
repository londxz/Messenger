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
    @Published var userSession: FirebaseAuth.User?
    
    init() {
        self.userSession = Auth.auth().currentUser
        print("user session id: \(userSession?.uid ?? "nil")")
    }
    
    func loginUser(email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            print("SUCCES in loginUser: \(result.user.uid)")
        } catch {
            print("ERROR in loginUser: \(error.localizedDescription)")
        }
    }
    
    func createUser(email: String, fullname: String, password: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            print("SUCCES in createUser: \(result.user.uid)")
        } catch {
            print("ERROR in createUser: \(error.localizedDescription)")
        }
    }
    
    func deleteUser() async throws {
        do {
            try await Auth.auth().currentUser?.delete()
            self.userSession = nil
        } catch {
            print("ERROR in deleteUser: \(error.localizedDescription)")
        }
    }
    
    func logoutUser() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
        } catch {
            print("ERROR in logoutUser: \(error.localizedDescription)")
        }
    }
}
