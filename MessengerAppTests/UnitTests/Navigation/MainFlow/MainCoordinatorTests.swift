//
//  MainCoordinatorTests.swift
//  MessengerAppTests
//
//  Created by Родион Холодов on 14.12.2025.
//

@testable import class MessengerApp.MainCoordinator
@testable import struct MessengerApp.UserModel
import XCTest

@MainActor
final class MainCoordinatorTests: XCTestCase {
    var sut: MainCoordinator!
    let testUserModel = UserModel(fullname: "fullname", email: "123@gmail.com")

    override func setUpWithError() throws {
        sut = MainCoordinator()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_showProfile_push_to_path() {
        let inboxVM = sut.makeInboxViewModel()

        inboxVM.onShowProfileTap?(testUserModel)

        XCTAssert(sut.path.count == 1)
        XCTAssert(sut.path.last == .profile(testUserModel))
    }

    func test_show_chat_push_to_path() {
        let inboxVM = sut.makeInboxViewModel()

        inboxVM.onShowChatTap?(testUserModel)

        XCTAssert(sut.path.count == 1)
        XCTAssert(sut.path.last == .chat(testUserModel))
    }

    func test_show_chat_from_newMessage() {
        let inboxVM = sut.makeInboxViewModel()
        let newMessageVM = sut.makeNewMessageViewModel()

        inboxVM.onShowNewMessageTap?()
        newMessageVM.onSendMessageTap?(testUserModel)

        XCTAssert(sut.path.count == 1)
        XCTAssert(sut.path.last == .chat(testUserModel))
        XCTAssert(sut.fullScreenRoute == nil)
    }

    func test_newMessage_presents_and_resets_path() {
        let inboxVM = sut.makeInboxViewModel()

        inboxVM.onShowNewMessageTap?()

        XCTAssert(sut.path.isEmpty == true)
        XCTAssert(sut.fullScreenRoute == .newMessage)
    }

    func test_go_back_from_newMessage() {
        let inboxVM = sut.makeInboxViewModel()
        let newMessageVM = sut.makeNewMessageViewModel()

        inboxVM.onShowNewMessageTap?()
        newMessageVM.onGoBackTap?()

        XCTAssert(sut.path.isEmpty == true)
        XCTAssert(sut.fullScreenRoute == nil)
    }
}
