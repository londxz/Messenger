//
//  BaseCoordinator.swift
//  MessengerApp
//
//  Created by Родион Холодов on 10.12.2025.
//

import Foundation

@MainActor
class BaseCoordinator<Route: Hashable>: ObservableObject {
    @Published var path = [Route]()
    
    func push(_ route: Route) {
        path.append(route)
    }
    
    func pop() {
        guard !path.isEmpty else {
            print("DEBUG: path is empty")
            return
        }
        
        _ = path.popLast()
    }
    
    func popToRoot() {
        path = []
    }
}
