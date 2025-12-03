//
//  InboxRowView.swift
//  MessengerApp
//
//  Created by Родион Холодов on 22.11.2025.
//

import SwiftUI

struct InboxRowView: View {
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            ProfileImageView(userModel: UserModel.mockUser, size: .medium)

            VStack(alignment: .leading, spacing: 4) {
                Text("Bruce Wayne")
                    .font(.headline)
                Text("Example of text message")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                    .lineLimit(2)
            }

            HStack {
                Text("Yesterday")
                Image(systemName: "chevron.right")
            }
            .foregroundStyle(.gray)
            .font(.footnote)
        }
    }
}

#Preview {
    InboxRowView()
}
