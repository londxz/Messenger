//
//  MainCoordinator.swift
//  MessengerApp
//
//  Created by Родион Холодов on 24.11.2025.
//

import Combine
import Foundation
import SwiftUI

final class MainCoordinator: BaseCoordinator<MainRoute> {
    @Published var fullScreenRoute: FullScreenRoute?

    private var cancellables = Set<AnyCancellable>()
    
    var pathBinding: Binding<[MainRoute]> {
        Binding(
            get: { [weak self] in
                self?.path ?? []
            },
            set: { [weak self] newPath in
                guard let self else { return }
                guard newPath.count != self.path.count else { return }

                DispatchQueue.main.async { [weak self] in
                    self?.path = newPath
                }
            }
        )
    }

    // MARK: - Make Views

    @ViewBuilder
    func makeInboxView() -> some View {
        InboxView(viewModel: makeInboxViewModel())
    }

    @ViewBuilder
    func makeNewMessageView() -> some View {
        NewMessageView(viewModel: makeNewMessageViewModel())
    }

    @ViewBuilder
    func makeProfileView(userModel: UserModel) -> some View {
        ProfileView(userModel: userModel)
    }

    @ViewBuilder
    func makeChatView(userModel: UserModel) -> some View {
        ChatView(userModel: userModel)
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

    private func makeNewMessageViewModel() -> NewMessageViewModel {
        let viewModel = NewMessageViewModel()

        viewModel.onGoBackTap = { [weak self] in
            self?.closeFullScreen()
        }

        viewModel.onSendMessageTap = { [weak self] userModel in
            self?.showChat(userModel: userModel)
        }

        return viewModel
    }

    private func showProfile(userModel: UserModel) {
        push(.profile(userModel))
    }

    private func showNewMessage() {
        popToRoot()
        fullScreenRoute = .newMessage
    }

    private func showChat(userModel: UserModel) {
        if fullScreenRoute == .newMessage {
            closeFullScreen()
        }
        
        if path.last == .chat(userModel) {
            return
        }

        push(.chat(userModel))
    }

    private func closeFullScreen() {
        fullScreenRoute = nil
    }
}
