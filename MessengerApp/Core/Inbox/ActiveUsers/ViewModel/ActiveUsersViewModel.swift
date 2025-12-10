//
//  ActiveUsersViewModel.swift
//  MessengerApp
//
//  Created by Родион Холодов on 08.12.2025.
//

import FirebaseAuth
import Foundation

class ActiveUsersViewModel: ObservableObject {
    @Published var users = [UserModel]()

    var onActiveUserTap: ((UserModel) -> Void)?

    @MainActor
    func fetchActiveUsers() async {
        guard let currentUserUid = Auth.auth().currentUser?.uid else { return }
        do {
            let users = try await UserService.shared.fetchAllUsers(limit: 5)
            self.users = users.filter { $0.id != currentUserUid }
        } catch {
            print("ERROR in ActiveUsersViewModel.fetchActiveUsers: \(error.localizedDescription)")
        }
    }

    // MARK: - Navigation

    func didTapActiveUser(userModel: UserModel) {
        onActiveUserTap?(userModel)
    }
}
