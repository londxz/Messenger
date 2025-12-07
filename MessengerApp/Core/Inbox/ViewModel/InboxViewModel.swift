//
//  InboxViewModel.swift
//  MessengerApp
//
//  Created by Родион Холодов on 03.12.2025.
//

import Combine
import Foundation
import FirebaseFirestore
import FirebaseAuth

class InboxViewModel: ObservableObject {
    @Published var user: UserModel?
    @Published var recentMessages = [MessageModel]()
    
    private let service = InboxService()
    private var cancellables = Set<AnyCancellable>()

    init() {
        setSubscribers()
        service.observeRecentMessages()
    }

    private func setSubscribers() {
        UserService.shared.$currentUser
            .receive(on: DispatchQueue.main)
            .sink { [weak self] user in
                self?.user = user
            }
            .store(in: &cancellables)
        
        service.$documentChanges
            .receive(on: DispatchQueue.main)
            .sink { [weak self] documentChanges in
                self?.loadInitialChanges(changes: documentChanges)
            }
            .store(in: &cancellables)
    }
    
    private func loadInitialChanges(changes: [DocumentChange]) {
        var messages = changes.compactMap({ try? $0.document.data(as: MessageModel.self) })
        
        for i in 0..<messages.count {
            let message = messages[i]
            
            UserService.shared.fetchUserFromUid(userUid: message.chatPartner) { [weak self] user in
                messages[i].userModel = user
                
                if let index = self?.recentMessages.firstIndex(where: { $0.chatPartner == message.chatPartner }) {
                    self?.recentMessages[index] = messages[i]
                } else {
                    self?.recentMessages.append(messages[i])
                }
                
                self?.sortMessages()
            }
        }
    }
    
    private func sortMessages() {
        recentMessages.sort { $0.timestamp.dateValue() > $1.timestamp.dateValue() }
    }
}
