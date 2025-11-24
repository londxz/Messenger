//
//  RootView.swift
//  MessengerApp
//
//  Created by Родион Холодов on 24.11.2025.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var coordinator: Coordinator

    var body: some View {
        NavigationStack(path: $router.path) {
            InboxView()
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case let .profile(userModel):
                        ProfileView(userModel: userModel)
                    }
                }
                .fullScreenCover(item: $router.fullScreenRoute) { route in
                    switch route {
                    case .newMessage:
                        NewMessageView()
                    }
                }
        }
        .tint(.black)
    }
}
