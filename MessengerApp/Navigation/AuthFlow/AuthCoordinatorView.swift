//
//  AuthCoordinatorView.swift
//  MessengerApp
//
//  Created by Родион Холодов on 01.12.2025.
//

import SwiftUI

struct AuthCoordinatorView: View {
    @ObservedObject var coordinator: AuthCoordinator
    
    init(coordinator: AuthCoordinator) {
        self.coordinator = coordinator
    }

    var body: some View {
        NavigationStack(path: $coordinator.path) {
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
