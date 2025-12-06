//
//  MessageService.swift
//  MessengerApp
//
//  Created by Родион Холодов on 06.12.2025.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class MessageService {
    static let shared = MessageService()
    let messageCollection = Firestore.firestore().collection("messages")
    
    func sendMessage(_ messageText: String, toUser user: UserModel) {
        guard let fromUserId = Auth.auth().currentUser?.uid else { return }
        let toUserId = user.id
        
        let fromUserRef = messageCollection.document(fromUserId).collection(toUserId).document()
        let toUserRef = messageCollection.document(toUserId).collection(fromUserId)
        
        let messageId = fromUserRef.documentID
        
        let message = MessageModel(
            fromId: fromUserId,
            toId: toUserId,
            messageText: messageText,
            timestamp: Timestamp()
        )
        
        do {
            try fromUserRef.setData(from: message)
            try toUserRef.document(messageId).setData(from: message)
            print("SUCCESS in MessageService.sendMessage")
        } catch {
            print("ERROR in MessageService.sendMessage: \(error.localizedDescription)")
        }
    }
}
