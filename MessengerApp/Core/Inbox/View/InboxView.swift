//
//  InboxView.swift
//  MessengerApp
//
//  Created by Родион Холодов on 22.11.2025.
//

import SwiftUI

struct InboxView: View {
    @StateObject private var viewModel = InboxViewModel()

    private let onShowProfileTap: (UserModel?) -> Void
    private let onShowNewMessageTap: () -> Void

    init(
        onShowProfileTap: @escaping (UserModel?) -> Void,
        onShowNewMessageTap: @escaping () -> Void
    ) {
        self.onShowProfileTap = onShowProfileTap
        self.onShowNewMessageTap = onShowNewMessageTap
    }

    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    ActiveUsersView()
                        .frame(height: 100)
                        .padding(16)
                    List {
                        ForEach(viewModel.recentMessages) { message in
                            InboxRowView(message: message)
                        }
                    }
                    .listStyle(PlainListStyle())
                    .frame(height: max(0, geo.size.height - 100))
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    HStack(spacing: 0) {
                        Button {
                            onShowProfileTap(viewModel.user)
                        } label: {
                            ProfileImageView(userModel: viewModel.user, size: .xSmall)
                        }

                        Text("Chat")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        onShowNewMessageTap()
                    } label: {
                        Image(systemName: "square.and.pencil.circle.fill")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .foregroundStyle(.black, Color(.systemGray5))
                    }
                }
            }
        }
    }
}
