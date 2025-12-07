//
//  UserModel.swift
//  MessengerApp
//
//  Created by Родион Холодов on 23.11.2025.
//

import FirebaseFirestore
import Foundation

struct UserModel: Identifiable, Hashable, Codable {
    @DocumentID var uid: String?
    var fullname: String
    var email: String
    var profileImageUrl: String?

    var id: String { uid ?? UUID().uuidString }
}

extension UserModel {
    static let mockUser = UserModel(fullname: "No name", email: "noname@gmail.com", profileImageUrl: "batman")
}
