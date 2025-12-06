//
//  ChatView.swift
//  MessengerApp
//
//  Created by Родион Холодов on 24.11.2025.
//

import SwiftUI

struct ChatView: View {
    @StateObject private var viewModel: ChatViewModel
    private let userModel: UserModel

    init(userModel: UserModel) {
        self.userModel = userModel
        _viewModel = StateObject(wrappedValue: ChatViewModel(userModel: userModel))
    }

    var body: some View {
        VStack {
            GeometryReader { geo in
                ScrollView {
                    VStack {
                        ProfileImageView(userModel: userModel, size: .xLarge)

                        VStack(spacing: 4) {
                            Text(userModel.fullname)
                                .font(.title3)
                                .fontWeight(.semibold)

                            Text("Messenger")
                                .font(.footnote)
                                .foregroundStyle(.gray)
                        }
                    }
                    
                    if !viewModel.messages.isEmpty {
                        ForEach(viewModel.messages) { message in
                            ChatMessageCell(
                                messageModel: message,
                                isFromCurrentUser: message.isFromCurrentUser,
                                contentWidth: geo.size.width
                            )
                        }
                    }
                }
                .frame(width: geo.size.width)
            }

            HStack(alignment: .bottom, spacing: 0) {
                TextField("Send message...", text: $viewModel.messageText, axis: .vertical)
                    .padding()
                    .textInputAutocapitalization(.none)

                Button {
                    guard !viewModel.messageText.isEmpty else { return }
                    viewModel.sendMessage()
                } label: {
                    Text("Send")
                        .fontWeight(.semibold)
                        .padding(.vertical)
                        .padding(.trailing, 24)
                }
            }
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 24))
            .padding(.horizontal)
            .padding(.vertical, 8)
        }
    }
}
