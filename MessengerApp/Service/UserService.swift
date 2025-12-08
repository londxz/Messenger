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
            let documentSnapshot = try await FirebaseConstants.UsersCollection.document(uid).getDocument()
            let user = try documentSnapshot.data(as: UserModel.self)
            currentUser = user
            print(user)
        } catch {
            print("ERROR in fetchCurrentUser: \(error.localizedDescription)")
        }
    }

    func fetchAllUsers(limit: Int? = nil) async throws -> [UserModel] {
        let query = FirebaseConstants.UsersCollection
        
        if let limit = limit {
            query.limit(to: limit)
        }
        let querySnapshot = try await query.getDocuments()
        return querySnapshot.documents.compactMap { try? $0.data(as: UserModel.self) }
    }

    func fetchUserFromUid(userUid: String, completion: @escaping (UserModel) -> Void) {
        FirebaseConstants.UsersCollection.document(userUid).getDocument { snapshot, _ in
            guard let userModel = try? snapshot?.data(as: UserModel.self) else { return }
            completion(userModel)
        }
    }
}
