//
//  InboxView.swift
//  MessengerApp
//
//  Created by Родион Холодов on 22.11.2025.
//

import SwiftUI

struct InboxView: View {
    @State private var showNewMessage = false
    @State private var showProfile = false

    var body: some View {
        NavigationStack {
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
                .fullScreenCover(isPresented: $showNewMessage) {
                    NewMessageView()
                }
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        HStack(spacing: 0) {
                            Button {
                                print("Profile clicked")
                                showProfile.toggle()
                            } label: {
                                Image(systemName: "person.crop.circle")
                                    .resizable()
                                    .frame(width: 28, height: 28)
                            }
                            .foregroundStyle(.black)

                            Text("Chat")
                                .font(.title)
                                .fontWeight(.bold)
                        }
                    }

                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            showNewMessage.toggle()
                        } label: {
                            Image(systemName: "square.and.pencil.circle.fill")
                                .resizable()
                                .frame(width: 32, height: 32)
                                .foregroundStyle(.black, Color(.systemGray5))
                        }
                    }
                }
            }
            .navigationDestination(isPresented: $showProfile) {
                ProfileView()
            }
        }
    }
}

#Preview {
    InboxView()
}
