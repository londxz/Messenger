//
//  RegisterView.swift
//  MessengerApp
//
//  Created by Родион Холодов on 20.11.2025.
//

import SwiftUI

struct RegisterView: View {
    @StateObject private var viewModel = RegisterViewModel()

    init(viewModel: RegisterViewModel = RegisterViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ViewThatFits(in: .vertical) {
            registerView
            ScrollView { registerView }.scrollDismissesKeyboard(.interactively)
        }
        .padding(.horizontal, 28)
        .navigationBarBackButtonHidden()
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .onTapGesture { hideKeyboard() }
    }

    @ViewBuilder
    private var registerView: some View {
        VStack(spacing: 16) {
            Spacer()
            Image(.profileIcon)
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
                TextField("Enter your fullname", text: $viewModel.fullname)
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
            .padding(.bottom, 8)

            Button {
                Task { try await viewModel.createUser() }
            } label: {
                Text("Sign Up")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }

            Spacer()

            Divider()

            Button {
                viewModel.didTapBackToLogin()
            } label: {
                HStack {
                    Text("Already registered?")
                    Text("Sign In")
                        .fontWeight(.semibold)
                }
                .padding(.horizontal)
                .font(.footnote)
                .padding(.bottom)
            }
        }
    }
}
