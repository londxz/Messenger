//
//  Router.swift
//  MessengerApp
//
//  Created by Родион Холодов on 24.11.2025.
//

import Foundation

final class Router: ObservableObject {
    @Published var path: [Route] = []
    @Published var fullScreenRoute: FullScreenRoute?

    func push(_ route: Route) {
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
