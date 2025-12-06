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
    
    func observeMessages(chatPartnerUser: UserModel, completion: @escaping ([MessageModel]) -> Void) {
        guard let currentUserUid = Auth.auth().currentUser?.uid else { return }
        
        let query = messageCollection
            .document(currentUserUid)
            .collection(chatPartnerUser.id)
            .order(by: "timestamp")
        
        query.addSnapshotListener { snapshot, _ in
            guard let changes = snapshot?.documentChanges.filter({ $0.type == .added }) else { return }
            var messages = changes.compactMap { try? $0.document.data(as: MessageModel.self) }
            
            for (index, message) in messages.enumerated() where !message.isFromCurrentUser {
                messages[index].userModel = chatPartnerUser
            }
            
            completion(messages)
        }
    }
}
