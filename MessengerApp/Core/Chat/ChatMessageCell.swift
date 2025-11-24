//
//  ChatMessageCell.swift
//  MessengerApp
//
//  Created by Родион Холодов on 24.11.2025.
//

import SwiftUI

struct ChatMessageCell: View {
    let isFromCurrentUser: Bool
    let contentWidth: CGFloat

    var body: some View {
        if isFromCurrentUser {
            HStack {
                Spacer()

                Text("Hi")
                    .font(.subheadline)
                    .padding(.trailing, 4)
                    .padding(12)
                    .background(Color(.systemBlue))
                    .foregroundStyle(.white)
                    .clipShape(MessageBubbleShape(isFromCurrentUser: isFromCurrentUser))
                    .frame(maxWidth: contentWidth * 0.7, alignment: .trailing)
            }
            .padding(.horizontal)
        } else {
            HStack(alignment: .bottom) {
                ProfileImageView(userModel: UserModel.mockUser, size: .xxSmall)

                Text("This message was typed by current user longer really what look like This message was typed by current user longer really what look like")
                    .font(.subheadline)
                    .padding(.leading, 4)
                    .padding(12)
                    .background(Color(.systemGray5))
                    .foregroundStyle(.black)
                    .clipShape(MessageBubbleShape(isFromCurrentUser: isFromCurrentUser))
                    .frame(maxWidth: contentWidth * 0.5, alignment: .leading)

                Spacer()
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    ChatMessageCell(isFromCurrentUser: true, contentWidth: 440)
}
