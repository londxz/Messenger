//
//  ChatMessageCell.swift
//  MessengerApp
//
//  Created by Родион Холодов on 24.11.2025.
//

import SwiftUI

struct ChatMessageCell: View {
    let messageModel: MessageModel
    let isFromCurrentUser: Bool
    let contentWidth: CGFloat

    var body: some View {
        if messageModel.isFromCurrentUser {
            HStack {
                Spacer()

                Text(messageModel.messageText)
                    .font(.subheadline)
                    .padding(.trailing, 4)
                    .padding(12)
                    .background(Color(.systemBlue))
                    .foregroundStyle(.white)
                    .clipShape(MessageBubbleShape(isFromCurrentUser: messageModel.isFromCurrentUser))
                    .frame(maxWidth: contentWidth * 0.7, alignment: .trailing)
            }
            .padding(.horizontal)
        } else {
            HStack(alignment: .bottom) {
                ProfileImageView(userModel: messageModel.userModel, size: .xxSmall)

                Text(messageModel.messageText)
                    .font(.subheadline)
                    .padding(.leading, 4)
                    .padding(12)
                    .background(Color(.systemGray5))
                    .foregroundStyle(.black)
                    .clipShape(MessageBubbleShape(isFromCurrentUser: messageModel.isFromCurrentUser))
                    .frame(maxWidth: contentWidth * 0.5, alignment: .leading)

                Spacer()
            }
            .padding(.horizontal)
        }
    }
}
