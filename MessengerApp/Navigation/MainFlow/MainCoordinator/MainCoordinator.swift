//
//  MainCoordinator.swift
//  MessengerApp
//
//  Created by Родион Холодов on 24.11.2025.
//

import Combine
import Foundation
import SwiftUI

final class MainCoordinator: ObservableObject {
    var router: MainRouter

    private var cancellables = Set<AnyCancellable>()

    init(router: MainRouter = MainRouter()) {
        self.router = router
        bindRouterUpdates()
    }

    @ViewBuilder
    func makeInboxView() -> some View {
        InboxView(
            onShowProfileTap: { [weak self] userModel in
                self?.showProfile(userModel: userModel)
            },
            onShowNewMessageTap: { [weak self] in
                self?.showNewMessage()
            },
            onInboxMessageTap: { [weak self] userModel in
                self?.showChatFromInboxMessage(userModel: userModel)
            },
            onShowChatFromActiveUsersTap: { [weak self] userModel in
                self?.showChatFromInboxMessage(userModel: userModel)
            }
        )
    }

    @ViewBuilder
    func makeProfileView(userModel: UserModel?) -> some View {
        ProfileView(userModel: userModel)
    }

    @ViewBuilder
    func makeChatView(userModel: UserModel) -> some View {
        ChatView(userModel: userModel)
    }

    @ViewBuilder
    func makeNewMessageView() -> some View {
        NewMessageView(
            onGoBackTap: { [weak self] in
                self?.closeFullScreen()
            },
            onSendMessageTap: { [weak self] userModel in
                self?.showChatFromNewMessage(userModel: userModel)
            }
        )
    }

    private func showProfile(userModel: UserModel?) {
        router.push(.profile(userModel))
    }

    private func showNewMessage() {
        router.presentFullScreen(.newMessage)
    }

    private func closeFullScreen() {
        router.dismissFullScreen()
    }

    private func showChatFromNewMessage(userModel: UserModel) {
        closeFullScreen()
        router.push(.chatWithUser(userModel))
    }

    private func showChatFromInboxMessage(userModel: UserModel?) {
        router.push(.chatFromInbox(userModel))
    }
    
    private func showChatFromActiveUsers(userModel: UserModel) {
        router.push(.chatFromActiveUsers(userModel))
    }

    private func bindRouterUpdates() {
        router.objectWillChange
            .sink { [weak self] _ in
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)
    }
}
