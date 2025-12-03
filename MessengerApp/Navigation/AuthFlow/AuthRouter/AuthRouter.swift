//
//  AuthRouter.swift
//  MessengerApp
//
//  Created by Родион Холодов on 01.12.2025.
//

import Foundation

final class AuthRouter: ObservableObject {
    @Published var path: [AuthRoute] = []

    func push(_ route: AuthRoute) {
        path.append(route)
    }

    func pop() {
        guard !path.isEmpty else { return }
        _ = path.popLast()
    }
}
