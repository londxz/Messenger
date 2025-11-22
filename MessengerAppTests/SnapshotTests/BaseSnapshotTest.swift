//
//  BaseSnapshotTest.swift
//  MessengerApp
//
//  Created by Родион Холодов on 21.11.2025.
//

import SwiftUI
import SnapshotTesting
import XCTest

class BaseSnapshotTest<Content: View>: XCTestCase {
    let isRecord: SnapshotTestingConfiguration.Record = false
    
    func makeVC(
        content: () -> Content,
        style: UIUserInterfaceStyle = .light,
        sizeCategory: ContentSizeCategory = .medium,
        device: ViewImageConfig
    ) -> UIViewController {
        let rootView = content()
            .environment(\.sizeCategory, sizeCategory)

        let sut = UIHostingController(rootView: rootView)
        sut.overrideUserInterfaceStyle = style

        guard let size = device.size else {
            fatalError("ViewImageConfig must define a size")
        }

        sut.view.frame = CGRect(origin: .zero, size: size)
        sut.view.setNeedsLayout()
        sut.view.layoutIfNeeded()

        return sut
    }
    
    func verifySnapshot(
        content: @escaping () -> Content,
        style: UIUserInterfaceStyle = .light,
        sizeCategory: ContentSizeCategory = .medium,
        device: ViewImageConfig,
        traits: UITraitCollection? = nil,
        file: StaticString = #file,
        testName: String = #function
    ) {
        let sut = makeVC(
            content: content,
            style: style,
            sizeCategory: sizeCategory,
            device: device
        )

        withSnapshotTesting(record: isRecord) {
            if let traits {
                assertSnapshot(
                    of: sut,
                    as: .image(on: device, traits: traits),
                    file: file,
                    testName: testName
                )
            } else {
                assertSnapshot(
                    of: sut,
                    as: .image(on: device),
                    file: file,
                    testName: testName 
                )
            }
        }
    }
}
