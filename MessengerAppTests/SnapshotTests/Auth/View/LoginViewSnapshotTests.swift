//
//  LoginViewSnapshotTests.swift
//  MessengerAppTests
//
//  Created by Родион Холодов on 15.11.2025.
//

@testable import struct MessengerApp.LoginView
import SnapshotTesting
import SwiftUI
import XCTest

final class LoginViewSnapshotTests: BaseSnapshotTest<LoginView> {
    // MARK: - Device Tests

    func test_iPhone16Pro_Light() {
        verifySnapshot(
            content: { LoginView() },
            style: .light,
            device: .iPhone16Pro
        )
    }

    func test_iPhone16Pro_Dark() {
        verifySnapshot(
            content: { LoginView() },
            style: .dark,
            device: .iPhone16Pro
        )
    }

    func test_iPhoneSE_Light() {
        verifySnapshot(
            content: { LoginView() },
            style: .light,
            device: .iPhoneSe3dGen
        )
    }

    func test_iPhoneSE_Dark() {
        verifySnapshot(
            content: { LoginView() },
            style: .dark,
            device: .iPhoneSe3dGen
        )
    }

    // MARK: - Dynamic Type Tests

    // iPhone16Pro
    func test_iPhone16Pro_DynamicTypeXL() {
        verifySnapshot(
            content: { LoginView() },
            style: .light,
            sizeCategory: .extraLarge,
            device: .iPhone16Pro,
            traits: UITraitCollection(preferredContentSizeCategory: .extraLarge)
        )
    }

    func test_iPhone16Pro_DynamicTypeXXXL() {
        verifySnapshot(
            content: { LoginView() },
            style: .light,
            sizeCategory: .extraExtraExtraLarge,
            device: .iPhone16Pro,
            traits: UITraitCollection(preferredContentSizeCategory: .extraExtraExtraLarge)
        )
    }

    func test_iPhone16Pro_DynamicTypeAXL() {
        verifySnapshot(
            content: { LoginView() },
            style: .light,
            sizeCategory: .accessibilityExtraLarge,
            device: .iPhone16Pro,
            traits: UITraitCollection(preferredContentSizeCategory: .accessibilityExtraLarge)
        )
    }

    func test_iPhone16Pro_DynamicTypeAXXXL() {
        verifySnapshot(
            content: { LoginView() },
            style: .light,
            sizeCategory: .accessibilityExtraExtraExtraLarge,
            device: .iPhone16Pro,
            traits: UITraitCollection(preferredContentSizeCategory: .accessibilityExtraExtraExtraLarge)
        )
    }

    // iPhoneSE3dGen
    func test_iPhoneSE_DynamicTypeXL() {
        verifySnapshot(
            content: { LoginView() },
            style: .light,
            sizeCategory: .extraLarge,
            device: .iPhoneSe3dGen,
            traits: UITraitCollection(preferredContentSizeCategory: .extraLarge)
        )
    }

    func test_iPhoneSE_DynamicTypeXXXL() {
        verifySnapshot(
            content: { LoginView() },
            style: .light,
            sizeCategory: .extraExtraExtraLarge,
            device: .iPhoneSe3dGen,
            traits: UITraitCollection(preferredContentSizeCategory: .extraExtraExtraLarge)
        )
    }

    func test_iPhoneSE_DynamicTypeAXL() {
        verifySnapshot(
            content: { LoginView() },
            style: .light,
            sizeCategory: .accessibilityExtraLarge,
            device: .iPhoneSe3dGen,
            traits: UITraitCollection(preferredContentSizeCategory: .accessibilityExtraLarge)
        )
    }

    func test_iPhoneSE_DynamicTypeAXXXL() {
        verifySnapshot(
            content: { LoginView() },
            style: .light,
            sizeCategory: .accessibilityExtraExtraExtraLarge,
            device: .iPhoneSe3dGen,
            traits: UITraitCollection(preferredContentSizeCategory: .accessibilityExtraExtraExtraLarge)
        )
    }
}
