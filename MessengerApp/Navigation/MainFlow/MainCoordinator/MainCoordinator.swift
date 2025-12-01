//
//  Coordinator.swift
//  MessengerApp
//
//  Created by Родион Холодов on 24.11.2025.
//

import Foundation

final class MainCoordinator: ObservableObject {
    let router: MainRouter

    init(router: MainRouter) {
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
    
    func reset() {
        router.reset()
    }
}
