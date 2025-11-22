//
//  ActiveUsersView.swift
//  MessengerApp
//
//  Created by Родион Холодов on 22.11.2025.
//

import SwiftUI

struct ActiveUsersView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 32) {
                ForEach(0 ... 10, id: \.self) { _ in
                    VStack {
                        ZStack(alignment: .bottomTrailing) {
                            Button {
                                print("user clicked")
                            } label: {
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .frame(width: 64, height: 64)
                                    .foregroundStyle(Color(.systemGray4))
                            }

                            ZStack {
                                Circle()
                                    .frame(width: 20, height: 20)
                                    .foregroundStyle(.white)
                                Circle()
                                    .frame(width: 12, height: 12)
                                    .foregroundStyle(.green)
                            }
                        }

                        Text("Tom")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                    }
                }
            }
        }
    }
}

#Preview {
    ActiveUsersView()
}
