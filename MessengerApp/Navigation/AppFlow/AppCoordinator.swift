//
//  AppCoordinator.swift
//  MessengerApp
//
//  Created by Родион Холодов on 01.12.2025.
//

import Combine
import FirebaseAuth

@MainActor
final class AppCoordinator: ObservableObject {
    @Published var appState: AppState = .loading
    let authService: AuthServiceProtocol

    private var cancellables: Set<AnyCancellable> = []

    init(authService: AuthServiceProtocol) {
        self.authService = authService
        setSubscribers()
    }

    private func setSubscribers() {
        authService.userSessionPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] userSession in
                self?.handleAuthChange(userSession: userSession)
            }
            .store(in: &cancellables)
    }

    private func handleAuthChange(userSession: FirebaseAuth.User?) {
        if userSession == nil {
            let coordinator = AuthCoordinator()
            appState = .authFlow(coordinator)
        } else {
            let coordinator = MainCoordinator()
            appState = .mainFlow(coordinator)
        }
    }
}
