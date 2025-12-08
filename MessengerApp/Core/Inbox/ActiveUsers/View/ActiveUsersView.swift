//
//  ActiveUsersView.swift
//  MessengerApp
//
//  Created by Родион Холодов on 22.11.2025.
//

import SwiftUI

struct ActiveUsersView: View {
    @StateObject private var viewModel = ActiveUsersViewModel()

    private let onActiveUserTap: (UserModel) -> Void

    init(onActiveUserTap: @escaping (UserModel) -> Void) {
        self.onActiveUserTap = onActiveUserTap
    }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 32) {
                ForEach(viewModel.users) { user in
                    VStack {
                        ZStack(alignment: .bottomTrailing) {
                            Button {
                                onActiveUserTap(user)
                            } label: {
                                ProfileImageView(userModel: user, size: .large)
                            }

                            ZStack {
                                Circle()
                                    .frame(width: 20, height: 20)
                                    .foregroundStyle(.white)
                                Circle()
                                    .frame(width: 12, height: 12)
                                    .foregroundStyle(.green)
                            }
                        }

                        Text(user.name)
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                    }
                }
            }
        }
        .task {
            await viewModel.fetchActiveUsers()
        }
    }
}
