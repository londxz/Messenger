//
//  InboxRowView.swift
//  MessengerApp
//
//  Created by Родион Холодов on 22.11.2025.
//

import SwiftUI

struct InboxRowView: View {
    let message: MessageModel
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            ProfileImageView(userModel: message.userModel, size: .medium)

            VStack(alignment: .leading, spacing: 4) {
                Text(message.userModel?.fullname ?? "No name")
                    .font(.headline)
                Text(message.messageText)
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                    .lineLimit(2)
            }
            
            Spacer()

            HStack {
                Text(message.timestampString)
                Image(systemName: "chevron.right")
            }
            .foregroundStyle(.gray)
            .font(.footnote)
        }
    }
}
