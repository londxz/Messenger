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
    private let onInboxMessageTap: (UserModel?) -> Void
    private let onShowChatFromActiveUsersTap: (UserModel) -> Void

    init(
        onShowProfileTap: @escaping (UserModel?) -> Void,
        onShowNewMessageTap: @escaping () -> Void,
        onInboxMessageTap: @escaping (UserModel?) -> Void,
        onShowChatFromActiveUsersTap: @escaping (UserModel) -> Void
    ) {
        self.onShowProfileTap = onShowProfileTap
        self.onShowNewMessageTap = onShowNewMessageTap
        self.onInboxMessageTap = onInboxMessageTap
        self.onShowChatFromActiveUsersTap = onShowChatFromActiveUsersTap
    }

    var body: some View {
        GeometryReader { geo in
            List {
                ActiveUsersView(onShowChatTap: onShowChatFromActiveUsersTap)
                    .frame(height: 100)
                    .listRowSeparator(.hidden)

                ForEach(viewModel.recentMessages) { message in
                    Button {
                        onInboxMessageTap(message.userModel)
                    } label: {
                        InboxRowView(message: message)
                    }
                }
            }
            .listStyle(PlainListStyle())
            .frame(height: max(0, geo.size.height - 100))
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
