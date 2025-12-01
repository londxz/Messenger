//
//  ProfileViewModel.swift
//  MessengerApp
//
//  Created by Родион Холодов on 22.11.2025.
//

import PhotosUI
import SwiftUI

class ProfileViewModel: ObservableObject {
    var loader: ImageLoader?

    @Published var profileImage: Image?
    @Published var selectedImage: PhotosPickerItem? {
        didSet {
            loader = selectedImage
            updateProfileImage()
        }
    }
    
    func logoutUser() {
        AuthService.shared.logoutUser()
    }
    
    func deleteUserAccount() async throws {
        try await AuthService.shared.deleteUser()
    }

    func loadProfileImage() async throws {
        guard
            let imageData = try await loader?.loadImageData(),
            let uiImage = UIImage(data: imageData)
        else { return }

        await setProfileImage(uiImage: uiImage)
    }

    private func updateProfileImage() {
        Task {
            try await loadProfileImage()
        }
    }

    @MainActor
    private func setProfileImage(uiImage: UIImage) {
        profileImage = Image(uiImage: uiImage)
    }
}
