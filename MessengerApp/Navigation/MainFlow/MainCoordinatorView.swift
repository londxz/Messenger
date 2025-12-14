//
//  MainCoordinatorView.swift
//  MessengerApp
//
//  Created by Родион Холодов on 24.11.2025.
//

import SwiftUI

struct MainCoordinatorView: View {
    @ObservedObject var coordinator: MainCoordinator

    init(coordinator: MainCoordinator) {
        self.coordinator = coordinator
    }

    var body: some View {
        NavigationStack(path: coordinator.pathBinding) {
            coordinator.makeInboxView()
                .navigationDestination(for: MainRoute.self) { route in
                    switch route {
                    case let .profile(userModel):
                        coordinator.makeProfileView(userModel: userModel)
                    case let .chat(userModel):
                        coordinator.makeChatView(userModel: userModel)
                    }
                }
                .fullScreenCover(item: $coordinator.fullScreenRoute) { route in
                    switch route {
                    case .newMessage:
                        coordinator.makeNewMessageView()
                    }
                }
        }
        .tint(.black)
    }
}
