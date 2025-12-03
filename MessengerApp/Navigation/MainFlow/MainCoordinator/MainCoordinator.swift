//
//  MainCoordinator.swift
//  MessengerApp
//
//  Created by Родион Холодов on 24.11.2025.
//

import Foundation
import SwiftUI
import Combine

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
            }
        )
    }
    
    @ViewBuilder
    func makeProfileView(userModel: UserModel) -> some View {
        ProfileView(userModel: userModel)
    }
    
    @ViewBuilder
    func makeNewMessageView() -> some View {
        NewMessageView(
            onGoBackTap: { [weak self] in
                self?.closeFullScreen()
            }
        )
    }

    private func showProfile(userModel: UserModel) {
        router.push(.profile(userModel))
    }

    private func showNewMessage() {
        router.presentFullScreen(.newMessage)
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
