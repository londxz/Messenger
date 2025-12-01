//
//  LoginViewModel.swift
//  MessengerApp
//
//  Created by Родион Холодов on 01.12.2025.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    
    func loginUser() async throws {
        try await AuthService.shared.loginUser(email: email, password: password)
    }
}
