//
//  ImageLoader.swift
//  MessengerApp
//
//  Created by Родион Холодов on 23.11.2025.
//

import Foundation

protocol ImageLoader {
    func loadImageData() async throws -> Data?
}
