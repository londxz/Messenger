//
//  AuthServiceProtocol.swift
//  MessengerApp
//
//  Created by Родион Холодов on 12.12.2025.
//

import Combine
import FirebaseAuth

protocol AuthServiceProtocol {
    var userSessionPublisher: AnyPublisher<FirebaseAuth.User?, Never> { get }
}
