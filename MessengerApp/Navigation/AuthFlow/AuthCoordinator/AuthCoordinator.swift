//
//  AuthCoordinator.swift
//  MessengerApp
//
//  Created by Родион Холодов on 01.12.2025.
//

import Foundation

final class AuthCoordinator: ObservableObject {
    let router: AuthRouter
    
    init(router: AuthRouter) {
        self.router = router
    }
    
    func pushRegisterationView() {
        router.push(.registration)
    }
    
    func goBack() {
        router.pop()
    }
}
