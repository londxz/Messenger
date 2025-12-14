//
//  AppCoordinatorTests.swift
//  MessengerAppTests
//
//  Created by Родион Холодов on 14.12.2025.
//

import Combine
@testable import class MessengerApp.AppCoordinator
@testable import enum MessengerApp.AppState
@testable import protocol MessengerApp.AuthServiceProtocol
@testable import struct MessengerApp.UserSession
import XCTest

@MainActor
final class AppCoordinatorTests: XCTestCase {
    var sut: AppCoordinator!
    var mockAuthService: MockAuthService!
    var cancellables: Set<AnyCancellable>!

    override func setUpWithError() throws {
        mockAuthService = MockAuthService()
        sut = AppCoordinator(authService: mockAuthService)
        cancellables = []
    }

    override func tearDownWithError() throws {
        mockAuthService = nil
        sut = nil
        cancellables = nil
    }

    func test_appState_switchesToAuthFlow_whenUserLogsOut() {
        mockAuthService.simulateLogin()

        let expectation = XCTestExpectation(description: "switch to auth flow")

        sut.$appState
            .dropFirst()
            .sink { appState in
                if case .authFlow = appState {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        mockAuthService.simulateLogout()

        wait(for: [expectation], timeout: 1.0)
    }

    func test_appState_switchesToMainFlow_whenUserLogsIn() {
        mockAuthService.simulateLogout()

        let expectation = XCTestExpectation(description: "switch to main flow")

        sut.$appState
            .dropFirst()
            .sink { appState in
                if case .mainFlow = appState {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        mockAuthService.simulateLogin()

        wait(for: [expectation], timeout: 1.0)
    }
}

final class MockAuthService: AuthServiceProtocol {
    let subject = CurrentValueSubject<UserSession?, Never>(nil)

    var userSessionPublisher: AnyPublisher<UserSession?, Never> {
        subject.eraseToAnyPublisher()
    }

    func simulateLogin() {
        let userSession = UserSession(uid: "uid")
        subject.send(userSession)
    }

    func simulateLogout() {
        subject.send(nil)
    }
}
