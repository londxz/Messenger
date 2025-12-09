//
//  ChatViewModel.swift
//  MessengerApp
//
//  Created by Родион Холодов on 06.12.2025.
//

import Foundation

class ChatViewModel: ObservableObject {
    @Published var messageText = ""
    @Published var messages = [MessageModel]()
    let service: ChatService

    init(chatPartner: UserModel) {
        service = ChatService(chatPartner: chatPartner)
        observeMessages()
    }

    func observeMessages() {
        service.observeMessages { [weak self] message in
            self?.messages.append(contentsOf: message)
        }
    }

    func sendMessage() {
        messageText = messageText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !messageText.isEmpty else { return }
        service.sendMessage(messageText)
        messageText = ""
    }
}
