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

final class LoginViewSnapshotTests: XCTestCase {
    let isRecord: SnapshotTestingConfiguration.Record = false

    func makeVC(
        style: UIUserInterfaceStyle = .light,
        sizeCategory: ContentSizeCategory = .medium,
        config: ViewImageConfig
    ) -> UIViewController {
        let rootView = LoginView()
            .environment(\.sizeCategory, sizeCategory)

        let sut = UIHostingController(rootView: rootView)
        sut.overrideUserInterfaceStyle = style

        guard let size = config.size else {
            fatalError("ViewImageConfig must define a size")
        }

        sut.view.frame = CGRect(origin: .zero, size: size)
        sut.view.setNeedsLayout()
        sut.view.layoutIfNeeded()

        return sut
    }

    // MARK: - Device Tests

    func test_iPhone16Pro_Light() {
        let sut = makeVC(style: .light, config: .iPhone16Pro)
        withSnapshotTesting(record: isRecord) {
            assertSnapshot(of: sut, as: .image(on: .iPhone16Pro))
        }
    }

    func test_iPhone16Pro_Dark() {
        let sut = makeVC(style: .dark, config: .iPhone16Pro)
        withSnapshotTesting(record: isRecord) {
            assertSnapshot(of: sut, as: .image(on: .iPhone16Pro))
        }
    }

    func test_iPhoneSE_Light() {
        let sut = makeVC(style: .light, config: .iPhoneSe3dGen)
        withSnapshotTesting(record: isRecord) {
            assertSnapshot(of: sut, as: .image(on: .iPhoneSe3dGen))
        }
    }

    func test_iPhoneSE_Dark() {
        let sut = makeVC(style: .dark, config: .iPhoneSe3dGen)
        withSnapshotTesting(record: isRecord) {
            assertSnapshot(of: sut, as: .image(on: .iPhoneSe3dGen))
        }
    }

    // MARK: - Dynamic Type Tests

    // iPhone16Pro
    func test_iPhone16Pro_DynamicTypeXL() {
        let sut = makeVC(
            style: .light,
            sizeCategory: .extraLarge,
            config: .iPhone16Pro
        )

        withSnapshotTesting(record: isRecord) {
            assertSnapshot(
                of: sut,
                as: .image(
                    on: .iPhone16Pro,
                    traits: UITraitCollection(
                        preferredContentSizeCategory: .extraLarge
                    )
                )
            )
        }
    }

    func test_iPhone16Pro_DynamicTypeXXXL() {
        let sut = makeVC(
            style: .light,
            sizeCategory: .extraExtraExtraLarge,
            config: .iPhone16Pro
        )

        withSnapshotTesting(record: isRecord) {
            assertSnapshot(
                of: sut,
                as: .image(
                    on: .iPhone16Pro,
                    traits: UITraitCollection(
                        preferredContentSizeCategory: .extraExtraExtraLarge
                    )
                )
            )
        }
    }

    func test_iPhone16Pro_DynamicTypeAXL() {
        let sut = makeVC(
            style: .light,
            sizeCategory: .accessibilityExtraLarge,
            config: .iPhone16Pro
        )

        withSnapshotTesting(record: isRecord) {
            assertSnapshot(
                of: sut,
                as: .image(
                    on: .iPhone16Pro,
                    traits: UITraitCollection(
                        preferredContentSizeCategory: .accessibilityExtraLarge
                    )
                )
            )
        }
    }

    func test_iPhone16Pro_DynamicTypeAXXXL() {
        let sut = makeVC(
            style: .light,
            sizeCategory: .accessibilityExtraExtraExtraLarge,
            config: .iPhone16Pro
        )

        withSnapshotTesting(record: isRecord) {
            assertSnapshot(
                of: sut,
                as: .image(
                    on: .iPhone16Pro,
                    traits: UITraitCollection(
                        preferredContentSizeCategory: .accessibilityExtraExtraExtraLarge
                    )
                )
            )
        }
    }

    // iPhoneSE3dGen
    func test_iPhoneSE_DynamicTypeXL() {
        let sut = makeVC(
            style: .light,
            sizeCategory: .extraLarge,
            config: .iPhoneSe3dGen
        )

        withSnapshotTesting(record: isRecord) {
            assertSnapshot(
                of: sut,
                as: .image(
                    on: .iPhoneSe3dGen,
                    traits: UITraitCollection(
                        preferredContentSizeCategory: .extraLarge
                    )
                )
            )
        }
    }

    func test_iPhoneSE_DynamicTypeXXXL() {
        let sut = makeVC(
            style: .light,
            sizeCategory: .extraExtraExtraLarge,
            config: .iPhoneSe3dGen
        )

        withSnapshotTesting(record: isRecord) {
            assertSnapshot(
                of: sut,
                as: .image(
                    on: .iPhoneSe3dGen,
                    traits: UITraitCollection(
                        preferredContentSizeCategory: .extraExtraExtraLarge
                    )
                )
            )
        }
    }

    func test_iPhoneSE_DynamicTypeAXL() {
        let sut = makeVC(
            style: .light,
            sizeCategory: .accessibilityExtraLarge,
            config: .iPhoneSe3dGen
        )

        withSnapshotTesting(record: isRecord) {
            assertSnapshot(
                of: sut,
                as: .image(
                    on: .iPhoneSe3dGen,
                    traits: UITraitCollection(
                        preferredContentSizeCategory: .accessibilityExtraLarge
                    )
                )
            )
        }
    }

    func test_iPhoneSE_DynamicTypeAXXXL() {
        let sut = makeVC(
            style: .light,
            sizeCategory: .accessibilityExtraExtraExtraLarge,
            config: .iPhoneSe3dGen
        )

        withSnapshotTesting(record: isRecord) {
            assertSnapshot(
                of: sut,
                as: .image(
                    on: .iPhoneSe3dGen,
                    traits: UITraitCollection(
                        preferredContentSizeCategory: .accessibilityExtraExtraExtraLarge
                    )
                )
            )
        }
    }
}

extension ViewImageConfig {
    static let iPhone16Pro = ViewImageConfig(size: CGSize(width: 402, height: 874))
    static let iPhoneSe3dGen = ViewImageConfig(size: CGSize(width: 375, height: 667))
}
