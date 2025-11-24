//
//  Coordinator.swift
//  MessengerApp
//
//  Created by Родион Холодов on 24.11.2025.
//

import Foundation

final class Coordinator: ObservableObject {
    let router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    func showProfile(userModel: UserModel) {
        router.push(.profile(userModel))
    }
    
    func showNewMessage() {
        router.presentFullScreen(.newMessage)
    }
    
    func goBack() {
        router.pop()
    }
    
    func closeFullScreen() {
        router.dismissFullScreen()
    }
}
