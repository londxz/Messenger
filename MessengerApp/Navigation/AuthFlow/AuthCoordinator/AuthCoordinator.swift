//
//  AuthCoordinator.swift
//  MessengerApp
//
//  Created by Родион Холодов on 01.12.2025.
//

import Foundation
import SwiftUI
import Combine

final class AuthCoordinator: ObservableObject {
    var router: AuthRouter
    
    private var cancellables = Set<AnyCancellable>()

    init(router: AuthRouter = AuthRouter()) {
        self.router = router
        bindRouterUpdates()
    }
    
    @ViewBuilder
    func makeLoginView() -> some View {
        LoginView { [weak self] in
            self?.pushRegisterationView()
        }
    }
    
    @ViewBuilder
    func makeRegisterView() -> some View {
        RegisterView { [weak self] in
            self?.goBack()
        }
    }
    
    private func pushRegisterationView() {
        router.push(.registration)
    }

    private func goBack() {
        router.pop()
    }
    
    private func bindRouterUpdates() {
        router.objectWillChange
            .sink { [weak self] _ in
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)
    }
}
