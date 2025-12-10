//
//  InboxViewModel.swift
//  MessengerApp
//
//  Created by Родион Холодов on 03.12.2025.
//

import Combine
import FirebaseAuth
import FirebaseFirestore
import Foundation

class InboxViewModel: ObservableObject {
    @Published var user: UserModel?
    @Published var recentMessages = [MessageModel]()
    
    let activeUsersViewModel = ActiveUsersViewModel()

    private let service = InboxService()
    private var cancellables = Set<AnyCancellable>()

    var onShowProfileTap: ((UserModel) -> Void)?
    var onShowNewMessageTap: (() -> Void)?
    var onShowChatTap: ((UserModel) -> Void)?

    init() {
        setSubscribers()
        setupActiveUsersViewModel()
        service.observeRecentMessages()
    }

    private func setSubscribers() {
        UserService.shared.$currentUser
            .receive(on: DispatchQueue.main)
            .sink { [weak self] user in
                self?.user = user
            }
            .store(in: &cancellables)

        service.$documentChanges
            .receive(on: DispatchQueue.main)
            .sink { [weak self] documentChanges in
                self?.loadInitialChanges(changes: documentChanges)
            }
            .store(in: &cancellables)
    }
    
    private func setupActiveUsersViewModel() {
        activeUsersViewModel.onActiveUserTap = { [weak self] userModel in
            self?.didTapActiveUserFromInbox(userModel: userModel)
        }
    }

    private func loadInitialChanges(changes: [DocumentChange]) {
        var messages = changes.compactMap { try? $0.document.data(as: MessageModel.self) }

        for index in 0 ..< messages.count {
            let message = messages[index]

            UserService.shared.fetchUserFromUid(userUid: message.chatPartner) { [weak self] user in
                messages[index].userModel = user

                if let existingUserIndex = self?.recentMessages.firstIndex(where: { $0.chatPartner == message.chatPartner }) {
                    self?.recentMessages[existingUserIndex] = messages[index]
                } else {
                    self?.recentMessages.append(messages[index])
                }

                self?.sortMessages()
            }
        }
    }

    private func sortMessages() {
        recentMessages.sort { $0.timestamp.dateValue() > $1.timestamp.dateValue() }
    }

    // MARK: - Navigation

    func didTapInboxMessage(message: MessageModel) {
        guard let userModel = message.userModel else {
            print("ERROR in InboxViewModel.didTapInboxMessage: userModel == nil")
            return
        }

        onShowChatTap?(userModel)
    }
    
    func didTapActiveUserFromInbox(userModel: UserModel) {
        onShowChatTap?(userModel)
    }

    func didTapShowProfile() {
        guard let userModel = user else {
            print("ERROR in InboxViewModel.didTapShowProfile: userModel == nil")
            return
        }

        onShowProfileTap?(userModel)
    }

    func didTapShowNewMessage() {
        onShowNewMessageTap?()
    }
}
