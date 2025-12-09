//
//  AuthCoordinator.swift
//  MessengerApp
//
//  Created by Родион Холодов on 01.12.2025.
//

import Combine
import Foundation
import SwiftUI

final class AuthCoordinator: ObservableObject {
    var router: AuthRouter

    private var cancellables = Set<AnyCancellable>()

    init(router: AuthRouter = AuthRouter()) {
        self.router = router
        bindRouterUpdates()
    }

    // MARK: - Make Views

    @ViewBuilder
    func makeLoginView() -> some View {
        LoginView(viewModel: makeLoginViewModel())
    }

    @ViewBuilder
    func makeRegisterView() -> some View {
        RegisterView(viewModel: makeRegisterViewModel())
    }

    // MARK: - Make ViewModels

    func makeLoginViewModel() -> LoginViewModel {
        let viewModel = LoginViewModel()

        viewModel.onRegistrationTap = { [weak self] in
            self?.pushRegisterationView()
        }

        return viewModel
    }

    func makeRegisterViewModel() -> RegisterViewModel {
        let viewModel = RegisterViewModel()

        viewModel.onGoBackToLoginTap = { [weak self] in
            self?.goBack()
        }

        return viewModel
    }

    // MARK: - Use AuthRouter

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
