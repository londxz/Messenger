//
//  MainFlowRootView.swift
//  MessengerApp
//
//  Created by Родион Холодов on 24.11.2025.
//

import SwiftUI

struct MainFlowRootView: View {
    @EnvironmentObject var mainRouter: MainRouter

    var body: some View {
        NavigationStack(path: $mainRouter.path) {
            InboxView()
                .navigationDestination(for: MainRoute.self) { route in
                    switch route {
                    case let .profile(userModel):
                        ProfileView(userModel: userModel)
                    }
                }
                .fullScreenCover(item: $mainRouter.fullScreenRoute) { route in
                    switch route {
                    case .newMessage:
                        NewMessageView()
                    }
                }
        }
        .tint(.black)
    }
}
