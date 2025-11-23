//
//  PhotosPickerItem+ImageLoader.swift
//  MessengerApp
//
//  Created by Родион Холодов on 23.11.2025.
//

import PhotosUI
import SwiftUI

extension PhotosPickerItem: ImageLoader {
    func loadImageData() async throws -> Data? {
        try await loadTransferable(type: Data.self)
    }
}
