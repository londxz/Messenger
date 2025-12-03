//
//  NewMessageView.swift
//  MessengerApp
//
//  Created by Родион Холодов on 22.11.2025.
//

import SwiftUI

struct NewMessageView: View {
    @State private var searchText = ""

    private let onGoBackTap: () -> Void

    init(onGoBackTap: @escaping () -> Void) {
        self.onGoBackTap = onGoBackTap
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                TextField("To:", text: $searchText)
                    .padding(.leading)
                    .frame(height: 44)
                    .background(Color(.systemGroupedBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding(.horizontal)

                Text("CONTACTS")
                    .font(.footnote)
                    .foregroundStyle(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()

                ForEach(0 ... 10, id: \.self) { _ in
                    HStack {
                        ProfileImageView(userModel: UserModel.mockUser, size: .small)
                        Text("Bruce Wayne")
                            .font(.subheadline)
                            .fontWeight(.semibold)

                        Spacer()
                    }
                    .padding(.leading)

                    Divider()
                        .padding(.leading, 64)
                }
            }

            .navigationTitle("New Message")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        onGoBackTap()
                    }
                }
            }
        }
    }
}
