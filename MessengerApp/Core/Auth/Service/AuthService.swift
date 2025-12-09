//
//  AuthService.swift
//  MessengerApp
//
//  Created by Родион Холодов on 01.12.2025.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

class AuthService {
    static let shared = AuthService()
    @Published var userSession: FirebaseAuth.User?

    init() {
        userSession = Auth.auth().currentUser
        fetchCurrentUser()
        print("user session id: \(userSession?.uid ?? "nil")")
    }

    func loginUser(email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            userSession = result.user
            fetchCurrentUser()
            print("SUCCES in loginUser: \(result.user.uid)")
        } catch {
            print("ERROR in loginUser: \(error.localizedDescription)")
        }
    }

    func createUser(email: String, fullname: String, password: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            userSession = result.user
            try await uploadUserData(email: email, fullname: fullname)
            fetchCurrentUser()
            print("SUCCES in createUser: \(result.user.uid)")
        } catch {
            print("ERROR in createUser: \(error.localizedDescription)")
        }
    }

    func deleteUser() async throws {
        do {
            try await Auth.auth().currentUser?.delete()
            resetUser()
        } catch {
            print("ERROR in deleteUser: \(error.localizedDescription)")
        }
    }

    func logoutUser() {
        do {
            try Auth.auth().signOut()
            resetUser()
        } catch {
            print("ERROR in logoutUser: \(error.localizedDescription)")
        }
    }

    private func uploadUserData(email: String, fullname: String) async throws {
        let user = UserModel(fullname: fullname, email: email)

        do {
            try FirebaseConstants.UsersCollection.document(userSession?.uid ?? "").setData(from: user)
            print("SUCCESS in uploadUserData")
        } catch {
            print("ERROR in uploadUserData: \(error.localizedDescription)")
        }
    }

    private func fetchCurrentUser() {
        Task { try await UserService.shared.fetchCurrentUser() }
    }

    private func resetUser() {
        userSession = nil
        UserService.shared.currentUser = nil
    }
}
