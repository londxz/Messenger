//
//  LoginView.swift
//  MessengerApp
//
//  Created by Родион Холодов on 15.11.2025.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()

    private let onRegistrationTap: () -> Void

    init(
        viewModel: LoginViewModel = LoginViewModel(),
        onRegistrationTap: @escaping () -> Void
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onRegistrationTap = onRegistrationTap
    }

    var body: some View {
        ViewThatFits(in: .vertical) {
            loginView
            ScrollView { loginView }
        }
        .padding(.horizontal, 28)
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }

    @ViewBuilder
    private var loginView: some View {
        VStack(spacing: 16) {
            Spacer()
            Image(.message)
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .padding(.bottom)
                .accessibilityHidden(true)

            VStack {
                TextField("Enter your email", text: $viewModel.email)
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                SecureField("Enter your password", text: $viewModel.password)
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }

            Button {
                print("Forgot password")
            } label: {
                Text("Forgot password?")
                    .font(.footnote)
                    .foregroundStyle(.blue)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.vertical, 8)
            }

            Button {
                Task { try await viewModel.loginUser() }
            } label: {
                Text("Login")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }

            HStack {
                Rectangle()
                    .frame(height: 0.5)
                Text("OR")
                    .font(.footnote)
                    .fontWeight(.semibold)
                Rectangle()
                    .frame(height: 0.5)
            }
            .foregroundStyle(.gray)
            .padding(.vertical, 8)

            Button {
                print("Continue with Google")
            } label: {
                HStack {
                    Image(.googleIcon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                    Text("Continue with Google")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundStyle(.blue)
                }
            }

            Spacer()

            Divider()

            Button {
                onRegistrationTap()
            } label: {
                HStack {
                    Text("Don't have an account?")
                    Text("Sign Up")
                        .fontWeight(.semibold)
                }
                .padding(.horizontal)
                .font(.footnote)
                .padding(.bottom)
            }
        }
    }
}
