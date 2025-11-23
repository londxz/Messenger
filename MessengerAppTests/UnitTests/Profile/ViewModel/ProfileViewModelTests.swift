//
//  ProfileViewModelTests.swift
//  MessengerAppTests
//
//  Created by Родион Холодов on 23.11.2025.
//

@testable import protocol MessengerApp.ImageLoader
@testable import class MessengerApp.ProfileViewModel
import XCTest

final class ProfileViewModelTests: XCTestCase {
    private var sut: ProfileViewModel!
    private var mockImageLoader: MockImageLoader!

    override func setUpWithError() throws {
        sut = ProfileViewModel()
        mockImageLoader = MockImageLoader()
    }

    func test_loadProfileImage_success_setsProfileImage() async throws {
        mockImageLoader.data = UIImage(systemName: "person")!.pngData()
        sut.loader = mockImageLoader

        try await sut.loadProfileImage()

        XCTAssert(sut.profileImage != nil)
    }

    func test_loadProfileImage_failure_invalidData_doesNotSetProfileImage() async throws {
        mockImageLoader.data = nil
        sut.loader = mockImageLoader

        try await sut.loadProfileImage()

        XCTAssert(sut.profileImage == nil)
    }

    func test_loadProfileImage_failure_throwError_doesNotSetProfileImage() async throws {
        mockImageLoader.error = NSError(domain: "test error", code: 0)
        sut.loader = mockImageLoader

        do {
            try await sut.loadProfileImage()
            XCTFail("Expected Error")
        } catch {
            XCTAssert(sut.profileImage == nil)
        }
    }

    func test_loadProfileImage_from_main_thread() async throws {
        mockImageLoader.data = UIImage(systemName: "person")!.pngData()
        sut.loader = mockImageLoader

        let expectation = XCTestExpectation(description: "Image loaded")

        let cancellable = sut.$profileImage
            .dropFirst()
            .sink { _ in
                XCTAssert(Thread.isMainThread == true)
                expectation.fulfill()
            }

        try await sut.loadProfileImage()

        await fulfillment(of: [expectation], timeout: 1)

        cancellable.cancel()
    }
}

final class MockImageLoader: ImageLoader {
    var data: Data?
    var error: Error?

    func loadImageData() async throws -> Data? {
        if let error = error { throw error }
        return data
    }
}
