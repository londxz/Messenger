//
//  AppCoordinator.swift
//  MessengerApp
//
//  Created by Родион Холодов on 01.12.2025.
//

import Foundation

final class AppCoordinator: ObservableObject {
    @Published var appRoute: AppRoute = .mainFlow
}
