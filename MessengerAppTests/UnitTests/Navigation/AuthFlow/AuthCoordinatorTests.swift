//
//  AuthCoordinatorTests.swift
//  MessengerAppTests
//
//  Created by Родион Холодов on 14.12.2025.
//

import XCTest
@testable import class MessengerApp.AuthCoordinator
@testable import struct MessengerApp.UserModel

@MainActor
final class AuthCoordinatorTests: XCTestCase {

    var sut: AuthCoordinator!
    
    override func setUpWithError() throws {
        sut = AuthCoordinator()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_register_view_push_to_path() {
        let loginVM = sut.makeLoginViewModel()
        
        loginVM.onRegistrationTap?()
        
        XCTAssert(sut.path.count == 1)
        XCTAssert(sut.path.last == .registration)
    }
    
    func test_go_back_to_login_from_register() {
        let loginVM = sut.makeLoginViewModel()
        let registerVM = sut.makeRegisterViewModel()
        
        loginVM.onRegistrationTap?()
        registerVM.onGoBackToLoginTap?()
        
        XCTAssert(sut.path.isEmpty == true)
    }
}
