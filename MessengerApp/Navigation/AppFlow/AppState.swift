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
        switch(lhs, rhs) {
        case(.loading, .loading):
            return true
        case let (.authFlow(l), .authFlow(r)):
            return l === r
        case let (.mainFlow(l), .mainFlow(r)):
            return l === r
        default:
            return false
        }
    }
}
