//
//  AuthFlowRootView.swift
//  MessengerApp
//
//  Created by Родион Холодов on 01.12.2025.
//

import SwiftUI

struct AuthFlowRootView: View {
    @EnvironmentObject var authRouter: AuthRouter

    var body: some View {
        NavigationStack(path: $authRouter.path) {
            LoginView()
                .navigationDestination(for: AuthRoute.self) { route in
                    switch route {
                    case .registration:
                        RegisterView()
                    }
                }
        }
    }
}
