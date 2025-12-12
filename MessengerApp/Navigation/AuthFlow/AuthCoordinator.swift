//
//  AuthCoordinator.swift
//  MessengerApp
//
//  Created by Родион Холодов on 01.12.2025.
//

import Combine
import Foundation
import SwiftUI

final class AuthCoordinator: BaseCoordinator<AuthRoute> {
    private var cancellables = Set<AnyCancellable>()

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

    private func pushRegisterationView() {
        push(.registration)
    }

    private func goBack() {
        pop()
    }
}
