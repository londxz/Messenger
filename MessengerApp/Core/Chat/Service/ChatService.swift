//
//  ChatService.swift
//  MessengerApp
//
//  Created by Родион Холодов on 06.12.2025.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

struct ChatService {
    let chatPartner: UserModel
    
    func sendMessage(_ messageText: String) {
        guard let fromUserId = Auth.auth().currentUser?.uid else { return }
        let chatPartnerId = chatPartner.id
        
        let fromUserRef = FirebaseConstants.MessagesCollection.document(fromUserId).collection(chatPartnerId).document()
        let toUserRef = FirebaseConstants.MessagesCollection.document(chatPartnerId).collection(fromUserId)
        
        let messageId = fromUserRef.documentID
        
        let message = MessageModel(
            fromId: fromUserId,
            toId: chatPartnerId,
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
    
    func observeMessages(completion: @escaping ([MessageModel]) -> Void) {
        guard let currentUserUid = Auth.auth().currentUser?.uid else { return }
        
        let query = FirebaseConstants.MessagesCollection
            .document(currentUserUid)
            .collection(chatPartner.id)
            .order(by: "timestamp")
        
        query.addSnapshotListener { snapshot, _ in
            guard let changes = snapshot?.documentChanges.filter({ $0.type == .added }) else { return }
            var messages = changes.compactMap { try? $0.document.data(as: MessageModel.self) }
            
            for (index, message) in messages.enumerated() where !message.isFromCurrentUser {
                messages[index].userModel = chatPartner
            }
            
            completion(messages)
        }
    }
}
