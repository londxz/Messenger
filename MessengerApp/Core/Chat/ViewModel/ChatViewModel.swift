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
    let userModel: UserModel
    
    init(userModel: UserModel) {
        self.userModel = userModel
        observeMessages()
    }
    
    func observeMessages() {
        MessageService.shared.observeMessages(chatPartnerUser: userModel) { [weak self] message in
            self?.messages.append(contentsOf: message)
        }
    }
    
    func sendMessage() {
        MessageService.shared.sendMessage(messageText, toUser: userModel)
        messageText = ""
    }
}
