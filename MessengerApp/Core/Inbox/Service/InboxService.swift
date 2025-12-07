//
//  InboxService.swift
//  MessengerApp
//
//  Created by Родион Холодов on 07.12.2025.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class InboxService {
    @Published var documentChanges = [DocumentChange]()

    func observeRecentMessages() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let query = FirebaseConstants.MessagesCollection
            .document(uid)
            .collection("recent-messages")
            .order(by: "timestamp", descending: true)
            
        query.addSnapshotListener { [weak self] snapshot, _ in
            guard let documentChanges = snapshot?.documentChanges
                .filter({ $0.type == .added || $0.type == .modified
            }) else { return }
            
            self?.documentChanges = documentChanges
        }
    }
}
