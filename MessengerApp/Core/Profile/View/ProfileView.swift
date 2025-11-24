//
//  ProfileView.swift
//  MessengerApp
//
//  Created by Родион Холодов on 22.11.2025.
//

import PhotosUI
import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    private let userModel: UserModel

    init(userModel: UserModel) {
        self.userModel = userModel
    }

    var body: some View {
        VStack {
            PhotosPicker(selection: $viewModel.selectedImage) {
                if let profileImage = viewModel.profileImage {
                    profileImage
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                } else {
                    Image(userModel.profileImageUrl ?? "")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                }
            }

            Text("Bruce Wayne")
                .font(.title2)
                .fontWeight(.semibold)
        }

        List {
            Section {
                ForEach(SettingViewModel.allCases) { options in
                    HStack {
                        Image(systemName: options.imageName)
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundStyle(options.imageColor)

                        Text(options.title)
                            .font(.subheadline)
                    }
                }
            }

            Section {
                Button("Logout") {}

                Button("Delete account") {}
            }
            .foregroundStyle(.red)
        }
    }
}

#Preview {
    NavigationStack {
        ProfileView(userModel: UserModel.mockUser)
    }
}
