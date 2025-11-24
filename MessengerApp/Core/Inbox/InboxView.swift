//
//  InboxView.swift
//  MessengerApp
//
//  Created by Родион Холодов on 22.11.2025.
//

import SwiftUI

struct InboxView: View {
    @EnvironmentObject private var coordinator: Coordinator
    @State private var userModel = UserModel.mockUser

    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    ActiveUsersView()
                        .frame(height: 100)
                        .padding(16)
                    List {
                        ForEach(0 ... 10, id: \.self) { _ in
                            InboxRowView()
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
                            coordinator.showProfile(userModel: userModel)
                        } label: {
                            ProfileImageView(userModel: UserModel.mockUser, size: .xSmall)
                        }

                        Text("Chat")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        coordinator.showNewMessage()
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

#Preview {
    InboxView()
}
