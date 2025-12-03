//
//  AuthCoordinatorView.swift
//  MessengerApp
//
//  Created by Родион Холодов on 01.12.2025.
//

import SwiftUI

struct AuthCoordinatorView: View {
    @StateObject private var coordinator: AuthCoordinator

    init(coordinator: AuthCoordinator) {
        _coordinator = StateObject(wrappedValue: coordinator)
    }

    var body: some View {
        NavigationStack(path: $coordinator.router.path) {
            coordinator.makeLoginView()
                .navigationDestination(for: AuthRoute.self) { route in
                    switch route {
                    case .registration:
                        coordinator.makeRegisterView()
                    }
                }
        }
    }
}
