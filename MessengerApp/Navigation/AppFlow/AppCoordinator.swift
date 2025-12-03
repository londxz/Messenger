//
//  AppCoordinator.swift
//  MessengerApp
//
//  Created by Родион Холодов on 01.12.2025.
//

import Combine
import FirebaseAuth

final class AppCoordinator: ObservableObject {
    @Published var appState: AppState = .loading

    private var cancellables: Set<AnyCancellable> = []

    init() {
        setSubscribers()
    }
    
    func makeAuthCoordinator() -> AuthCoordinator {
        AuthCoordinator()
    }
    
    func makeMainCoordinator() -> MainCoordinator {
        MainCoordinator()
    }

    private func setSubscribers() {
        AuthService.shared.$userSession
            .receive(on: DispatchQueue.main)
            .sink { [weak self] userSession in
                if userSession == nil {
                    self?.appState = .authFlow
                } else {
                    self?.appState = .mainFlow
                }
            }
            .store(in: &cancellables)
    }
}
