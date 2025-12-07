//
//  FirebaseConstants.swift
//  MessengerApp
//
//  Created by Родион Холодов on 06.12.2025.
//

import FirebaseFirestore

enum FirebaseConstants {
    static let UsersCollection = Firestore.firestore().collection("users")
    static let MessagesCollection = Firestore.firestore().collection("messages")
}
