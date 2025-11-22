//
//  RegisterView.swift
//  MessengerApp
//
//  Created by Родион Холодов on 20.11.2025.
//

import SwiftUI

struct RegisterView: View {
    @Environment(\.dismiss) var dismiss
    @State private var emailText = ""
    @State private var fullnameText = ""
    @State private var passwordText = ""

    var body: some View {
        ViewThatFits(in: .vertical) {
            registerView
            ScrollView { registerView }
        }
        .padding(.horizontal, 28)
        .navigationBarBackButtonHidden()
        .ignoresSafeArea(.keyboard, edges: .bottom)
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
                TextField("Enter your email", text: $emailText)
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                TextField("Enter your fullname", text: $fullnameText)
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                SecureField("Enter your password", text: $passwordText)
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .padding(.bottom, 8)

            Button {
                print("Sign Up")
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
                dismiss()
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

#Preview {
    RegisterView()
}
