//
//  AppFlowRootView.swift
//  MessengerApp
//
//  Created by Родион Холодов on 01.12.2025.
//

import SwiftUI

struct AppFlowRootView: View {
    @StateObject private var appCoordinator = AppCoordinator()

    @StateObject private var authRouter: AuthRouter
    @StateObject private var authCoordinator: AuthCoordinator

    @StateObject private var mainRouter: MainRouter
    @StateObject private var mainCoordinator: MainCoordinator

    init() {
        let authRouter = AuthRouter()
        _authRouter = StateObject(wrappedValue: authRouter)
        _authCoordinator = StateObject(wrappedValue: AuthCoordinator(router: authRouter))

        let mainRouter = MainRouter()
        _mainRouter = StateObject(wrappedValue: mainRouter)
        _mainCoordinator = StateObject(wrappedValue: MainCoordinator(router: mainRouter))
    }

    var body: some View {
        Group {
            switch appCoordinator.appState {
            case .loading:
                ProgressView()
            case .authFlow:
                AuthFlowRootView()
                    .environmentObject(authRouter)
                    .environmentObject(authCoordinator)
            case .mainFlow:
                MainFlowRootView()
                    .environmentObject(mainRouter)
                    .environmentObject(mainCoordinator)
                    .onAppear {
                        mainCoordinator.reset()
                    }
            }
        }
        .animation(.easeInOut, value: appCoordinator.appState)
    }
}
