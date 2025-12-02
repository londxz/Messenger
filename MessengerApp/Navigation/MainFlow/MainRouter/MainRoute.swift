//
//  MainRoute.swift
//  MessengerApp
//
//  Created by Родион Холодов on 24.11.2025.
//

import Foundation

enum MainRoute: Hashable {
    case profile(UserModel)
}

enum FullScreenRoute: Identifiable {
    case newMessage

    var id: String { UUID().uuidString }
}
