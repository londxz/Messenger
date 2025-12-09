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
        _viewModel = StateObject(wrappedValue: ChatViewModel(chatPartner: userModel))
    }

    var body: some View {
        VStack {
            GeometryReader { geo in
                ScrollView {
                    if !viewModel.messages.isEmpty {
                        LazyVStack {
                            ForEach(viewModel.messages.reversed()) { message in
                                ChatMessageCell(
                                    messageModel: message,
                                    isFromCurrentUser: message.isFromCurrentUser,
                                    contentWidth: geo.size.width
                                )
                                .rotationEffect(Angle(degrees: 180))
                                .scaleEffect(x: -1.0, y: 1.0)
                            }
                        }
                        .padding(.bottom, 16)
                    }
                }
                .rotationEffect(Angle(degrees: 180))
                .scaleEffect(x: -1.0, y: 1.0)
                .frame(width: geo.size.width)
            }

            HStack(alignment: .bottom, spacing: 0) {
                TextField("Send message...", text: $viewModel.messageText, axis: .vertical)
                    .padding()
                    .textInputAutocapitalization(.none)

                Button {
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
        .navigationTitle(userModel.fullname)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                ProfileImageView(userModel: userModel, size: .xSmall)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarTitleDisplayMode(.inline)
    }
}
