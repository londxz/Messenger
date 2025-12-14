//
//  AuthService.swift
//  MessengerApp
//
//  Created by Родион Холодов on 01.12.2025.
//

import Combine
import FirebaseAuth
import FirebaseFirestore

class AuthService: AuthServiceProtocol {
    static let shared = AuthService()
    @Published var firebaseUser: FirebaseAuth.User?

    var userSessionPublisher: AnyPublisher<UserSession?, Never> {
        $firebaseUser
            .map { firebaseUser in
                guard let user = firebaseUser else {
                    return nil
                }
                
                return UserSession(uid: user.uid)
            }
            .eraseToAnyPublisher()
    }

    init() {
        firebaseUser = Auth.auth().currentUser
        fetchCurrentUser()
        print("user session id: \(firebaseUser?.uid ?? "nil")")
    }

    func loginUser(email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            firebaseUser = result.user
            fetchCurrentUser()
            print("SUCCES in loginUser: \(result.user.uid)")
        } catch {
            print("ERROR in loginUser: \(error.localizedDescription)")
        }
    }

    func createUser(email: String, fullname: String, password: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            firebaseUser = result.user
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
            try FirebaseConstants.UsersCollection.document(firebaseUser?.uid ?? "").setData(from: user)
            print("SUCCESS in uploadUserData")
        } catch {
            print("ERROR in uploadUserData: \(error.localizedDescription)")
        }
    }

    private func fetchCurrentUser() {
        Task { try await UserService.shared.fetchCurrentUser() }
    }

    private func resetUser() {
        firebaseUser = nil
        UserService.shared.currentUser = nil
    }
}
