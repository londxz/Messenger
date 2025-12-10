//
//  NewMessageView.swift
//  MessengerApp
//
//  Created by Родион Холодов on 22.11.2025.
//

import SwiftUI

struct NewMessageView: View {
    @StateObject private var viewModel = NewMessageViewModel()
    
    init(viewModel: NewMessageViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                TextField("To:", text: $viewModel.searchText)
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

                ForEach(viewModel.users) { user in
                    HStack {
                        ProfileImageView(userModel: user, size: .small)
                        Text(user.fullname)
                            .font(.subheadline)
                            .fontWeight(.semibold)

                        Spacer()
                    }
                    .padding(.leading)
                    .onTapGesture { viewModel.didTapSendMessage(userModel: user) }

                    Divider()
                        .padding(.leading, 64)
                }
            }

            .navigationTitle("New Message")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        viewModel.didTapGoBack()
                    }
                }
            }
        }
    }
}
