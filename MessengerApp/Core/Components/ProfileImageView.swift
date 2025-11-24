//
//  ProfileImageView.swift
//  MessengerApp
//
//  Created by Родион Холодов on 24.11.2025.
//

import SwiftUI

struct ProfileImageView: View {
    let userModel: UserModel
    let size: ProfileImageSize

    var body: some View {
        if let profileImage = userModel.profileImageUrl {
            Image(profileImage)
                .resizable()
                .scaledToFill()
                .frame(width: size.dimension, height: size.dimension)
                .clipShape(Circle())
        } else {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: size.dimension, height: size.dimension)
                .foregroundStyle(Color(.systemGray4))
        }
    }
}

#Preview {
    ProfileImageView(userModel: UserModel.mockUser, size: .xLarge)
}
