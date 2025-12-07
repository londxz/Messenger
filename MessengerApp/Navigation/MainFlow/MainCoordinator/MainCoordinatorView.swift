//
//  MainCoordinatorView.swift
//  MessengerApp
//
//  Created by Родион Холодов on 24.11.2025.
//

import SwiftUI

struct MainCoordinatorView: View {
    @StateObject private var coordinator: MainCoordinator

    init(coordinator: MainCoordinator) {
        _coordinator = StateObject(wrappedValue: coordinator)
    }

    var body: some View {
        NavigationStack(path: $coordinator.router.path) {
            coordinator.makeInboxView()
                .navigationDestination(for: MainRoute.self) { route in
                    switch route {
                    case let .profile(userModel):
                        coordinator.makeProfileView(userModel: userModel)
                    case let .chatWithUser(userModel):
                        coordinator.makeChatView(userModel: userModel)
                    case let .chatFromInbox(userModel):
                        coordinator.makeChatView(userModel: userModel ?? UserModel.mockUser)
                    }
                }
                .fullScreenCover(item: $coordinator.router.fullScreenRoute) { route in
                    switch route {
                    case .newMessage:
                        coordinator.makeNewMessageView()
                    }
                }
        }
        .tint(.black)
    }
}
