//
//  AppFlowRootView.swift
//  MessengerApp
//
//  Created by Родион Холодов on 01.12.2025.
//

import SwiftUI

struct AppCoordinatorView: View {
    @StateObject private var appCoordinator = AppCoordinator()

    var body: some View {
        Group {
            switch appCoordinator.appState {
            case .loading:
                ProgressView()
            case .authFlow:
                AuthCoordinatorView(coordinator: appCoordinator.makeAuthCoordinator())
            case .mainFlow:
                MainCoordinatorView(coordinator: appCoordinator.makeMainCoordinator())
            }
        }
        .animation(.easeInOut, value: appCoordinator.appState)
    }
}
