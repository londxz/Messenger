//
//  ProfileViewModel.swift
//  MessengerApp
//
//  Created by Родион Холодов on 22.11.2025.
//

import PhotosUI
import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var profileImage: Image?

    @Published var selectedImage: PhotosPickerItem? {
        didSet {
            Task {
                try await loadProfileImage()
            }
        }
    }

    func loadProfileImage() async throws {
        guard let item = selectedImage else { return }
        guard let imageData = try await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: imageData) else { return }
        profileImage = Image(uiImage: uiImage)
    }
}
