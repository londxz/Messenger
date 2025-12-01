//
//  RegisterViewModel.swift
//  MessengerApp
//
//  Created by Родион Холодов on 01.12.2025.
//

import Foundation

class RegisterViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var fullname: String = ""
    @Published var password: String = ""
    
    func createUser() async throws {
        try await AuthService.shared.createUser(email: email, fullname: fullname, password: password)
    }
}
