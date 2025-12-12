//
//  AppCoordinatorView.swift
//  MessengerApp
//
//  Created by Родион Холодов on 01.12.2025.
//

import SwiftUI

struct AppCoordinatorView: View {
    @ObservedObject var appCoordinator: AppCoordinator

    var body: some View {
        Group {
            switch appCoordinator.appState {
            case .loading:
                ProgressView()
            case let .authFlow(authCoordinator):
                AuthCoordinatorView(coordinator: authCoordinator)
            case let .mainFlow(mainCoordinator):
                MainCoordinatorView(coordinator: mainCoordinator)
            }
        }
        .animation(.easeInOut, value: appCoordinator.appState)
    }
}
