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

    var pathBinding: Binding<[MainRoute]> {
        Binding(
            get: { [weak self] in
                self?.router.path ?? []
            },
            set: { [weak self] newPath in
                guard let self else { return }
                guard newPath.count != self.router.path.count else { return }

                DispatchQueue.main.async { [weak self] in
                    self?.router.path = newPath
                }
            }
        )
    }

    init(router: MainRouter = MainRouter()) {
        self.router = router
        bindRouterUpdates()
    }

    // MARK: - Make Views

    @ViewBuilder
    func makeInboxView() -> some View {
        InboxView(viewModel: makeInboxViewModel())
    }

    @ViewBuilder
    func makeProfileView(userModel: UserModel) -> some View {
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
                self?.showChat(userModel: userModel)
            }
        )
    }

    // MARK: - Make ViewModels

    private func makeInboxViewModel() -> InboxViewModel {
        let viewModel = InboxViewModel()

        viewModel.onShowProfileTap = { [weak self] userModel in
            self?.showProfile(userModel: userModel)
        }

        viewModel.onShowNewMessageTap = { [weak self] in
            self?.showNewMessage()
        }

        viewModel.onShowChatTap = { [weak self] userModel in
            self?.showChat(userModel: userModel)
        }

        return viewModel
    }

    // MARK: - Use MainRouter

    private func showProfile(userModel: UserModel) {
        router.push(.profile(userModel))
    }

    private func showNewMessage() {
        router.presentFullScreen(.newMessage)
    }

    private func showChat(userModel: UserModel) {
        if router.fullScreenRoute == .newMessage {
            closeFullScreen()
        }

        if router.path.last == .chat(userModel) {
            return
        }

        router.push(.chat(userModel))
    }

    private func closeFullScreen() {
        router.dismissFullScreen()
    }

    private func bindRouterUpdates() {
        router.objectWillChange
            .sink { [weak self] _ in
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)
    }
}
