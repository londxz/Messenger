//
//  ChatView.swift
//  MessengerApp
//
//  Created by Родион Холодов on 24.11.2025.
//

import SwiftUI

struct ChatView: View {
    @State private var messageText = ""
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    ProfileImageView(userModel: UserModel.mockUser, size: .xLarge)
                    
                    VStack(spacing: 4) {
                        Text("Bruce Wayne")
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        Text("Messenger")
                            .font(.footnote)
                            .foregroundStyle(.gray)
                    }
                }
            }
            HStack(alignment: .bottom, spacing: 0) {
                TextField("Send message...", text: $messageText, axis: .vertical)
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

#Preview {
    ChatView()
}
