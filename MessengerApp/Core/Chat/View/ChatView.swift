//
//  ChatView.swift
//  MessengerApp
//
//  Created by Родион Холодов on 24.11.2025.
//

import SwiftUI

struct ChatView: View {
    @StateObject private var viewModel = ChatViewModel()
    @State private var userModel: UserModel

    init(userModel: UserModel) {
        self.userModel = userModel
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

                    ForEach(0 ... 15, id: \.self) { _ in
                        ChatMessageCell(
                            isFromCurrentUser: Bool.random(),
                            contentWidth: geo.size.width
                        )
                    }
                }
            }

            HStack(alignment: .bottom, spacing: 0) {
                TextField("Send message...", text: $viewModel.messageText, axis: .vertical)
                    .padding()
                    .textInputAutocapitalization(.none)

                Button {
                    print("send message")
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
