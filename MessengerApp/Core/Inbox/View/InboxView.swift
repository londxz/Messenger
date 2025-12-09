//
//  InboxView.swift
//  MessengerApp
//
//  Created by Родион Холодов on 22.11.2025.
//

import SwiftUI

struct InboxView: View {
    @StateObject private var viewModel = InboxViewModel()

    init(viewModel: InboxViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        GeometryReader { geo in
            List {
                ActiveUsersView(onActiveUserTap: { userModel in
                    viewModel.didTapActiveUser(userModel: userModel)
                })
                .frame(height: 100)
                .listRowSeparator(.hidden)

                ForEach(viewModel.recentMessages) { message in
                    Button {
                        viewModel.didTapInboxMessage(message: message)
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
                            viewModel.didTapShowProfile()
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
                        viewModel.didTapShowNewMessage()
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
