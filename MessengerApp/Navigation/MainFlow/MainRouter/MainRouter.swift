//
//  Router.swift
//  MessengerApp
//
//  Created by Родион Холодов on 24.11.2025.
//

import Foundation

final class MainRouter: ObservableObject {
    @Published var path: [MainRoute] = []
    @Published var fullScreenRoute: FullScreenRoute?

    func push(_ route: MainRoute) {
        path.append(route)
    }

    func presentFullScreen(_ route: FullScreenRoute) {
        fullScreenRoute = route
    }

    func pop() {
        guard !path.isEmpty else { return }
        _ = path.popLast()
    }

    func dismissFullScreen() {
        fullScreenRoute = nil
    }
}
