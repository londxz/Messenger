//
//  UserModel.swift
//  MessengerApp
//
//  Created by Родион Холодов on 23.11.2025.
//

import Foundation

struct UserModel: Identifiable, Hashable, Codable {
    var id = UUID().uuidString
    var fullname: String
    var email: String
    var profileImageUrl: String?
}

extension UserModel {
    static let mockUser = UserModel(fullname: "Batman", email: "batman@gmail.com", profileImageUrl: "batman")
}
