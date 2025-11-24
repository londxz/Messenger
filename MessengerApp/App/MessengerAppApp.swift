//
//  MessengerAppApp.swift
//  MessengerApp
//
//  Created by Родион Холодов on 15.11.2025.
//

import SwiftUI

@main
struct MessengerAppApp: App {
    @StateObject private var router: Router
    @StateObject private var coordinator: Coordinator

    init() {
        let router = Router()
        _router = StateObject(wrappedValue: router)
        _coordinator = StateObject(wrappedValue: Coordinator(router: router))
    }

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(router)
                .environmentObject(coordinator)
        }
    }
}
