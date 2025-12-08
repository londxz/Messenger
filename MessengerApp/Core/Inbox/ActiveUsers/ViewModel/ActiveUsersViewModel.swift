//
//  ActiveUsersViewModel.swift
//  MessengerApp
//
//  Created by Родион Холодов on 08.12.2025.
//

import Foundation
import FirebaseAuth

class ActiveUsersViewModel: ObservableObject {
    @Published var users = [UserModel]()
    
    init() {
        Task { try await fetchActiveUsers() }
    }
    
    @MainActor
    private func fetchActiveUsers() async throws {
        guard let currentUserUid = Auth.auth().currentUser?.uid else { return }
        let users = try await UserService.shared.fetchAllUsers(limit: 5)
        self.users = users.filter { $0.id != currentUserUid }
    }
}
