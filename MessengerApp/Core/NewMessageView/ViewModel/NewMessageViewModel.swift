//
//  NewMessageViewModel.swift
//  MessengerApp
//
//  Created by Родион Холодов on 04.12.2025.
//

import FirebaseAuth
import Foundation

class NewMessageViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var users = [UserModel]()

    var onGoBackTap: (() -> Void)?
    var onSendMessageTap: ((UserModel) -> Void)?

    init() {
        Task { try await fetchUsers() }
    }

    @MainActor
    func fetchUsers() async throws {
        guard let currentUserUid = Auth.auth().currentUser?.uid else { return }
        users = try await UserService.shared.fetchAllUsers()
        users = users.filter { $0.uid != currentUserUid }
    }

    // MARK: - Navigation

    func didTapGoBack() {
        onGoBackTap?()
    }

    func didTapSendMessage(userModel: UserModel) {
        onSendMessageTap?(userModel)
    }
}
