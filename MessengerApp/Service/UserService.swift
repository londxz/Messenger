//
//  UserService.swift
//  MessengerApp
//
//  Created by Родион Холодов on 02.12.2025.
//

import FirebaseFirestore
import Foundation

class UserService {
    static let shared = UserService()
    @Published var currentUser: UserModel?

    func fetchCurrentUser() async throws {
        guard let uid = AuthService.shared.userSession?.uid else {
            print("User isn't signed in")
            return
        }

        do {
            let documentSnapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
            let user = try documentSnapshot.data(as: UserModel.self)
            currentUser = user
            print(user)
        } catch {
            print("ERROR in fetchCurrentUser: \(error.localizedDescription)")
        }
    }
}
