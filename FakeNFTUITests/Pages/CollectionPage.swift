//
//  CollectionPage.swift
//  FakeNFTUITests
//
//  Created by MAKOVEY Vladislav on 07.04.2024.
//

import XCTest

struct CollectionPage {
    // MARK: - Dependency

    let app: XCUIApplication

    // MARK: - Element

    var firstCell: XCUIElement {
        app.collectionViews.children(matching: .cell).element(boundBy: .zero)
    }

    var screen: XCUIElement {
        app.otherElements[AC.collectionScreen]
    }
}
