//
//  AppState.swift
//  MessengerApp
//
//  Created by Родион Холодов on 01.12.2025.
//

enum AppState: Equatable {
    case loading
    case authFlow(AuthCoordinator)
    case mainFlow(MainCoordinator)

    static func == (lhs: AppState, rhs: AppState) -> Bool {
        switch (lhs, rhs) {
        case(.loading, .loading):
            return true
        case let (.authFlow(left), .authFlow(right)):
            return left === right
        case let (.mainFlow(left), .mainFlow(right)):
            return left === right
        default:
            return false
        }
    }
}
