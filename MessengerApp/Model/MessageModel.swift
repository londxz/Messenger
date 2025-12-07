//
//  MessageModel.swift
//  MessengerApp
//
//  Created by Родион Холодов on 06.12.2025.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

struct MessageModel: Identifiable, Hashable, Codable {
    @DocumentID var messageId: String?
    let fromId: String
    let toId: String
    let messageText: String
    let timestamp: Timestamp

    var userModel: UserModel?

    var id: String {
        messageId ?? UUID().uuidString
    }

    var chatPartner: String {
        fromId == Auth.auth().currentUser?.uid ? toId : fromId
    }

    var isFromCurrentUser: Bool {
        Auth.auth().currentUser?.uid == fromId
    }

    var timestampString: String {
        timestamp.dateValue().timestampString()
    }
}
