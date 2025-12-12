//
//  MessengerAppApp.swift
//  MessengerApp
//
//  Created by Родион Холодов on 15.11.2025.
//

import FirebaseCore
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _: UIApplication,
        didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct MessengerAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var appCoordinator = AppCoordinator(authService: AuthService.shared)

    var body: some Scene {
        WindowGroup {
            AppCoordinatorView(appCoordinator: appCoordinator)
        }
    }
}
