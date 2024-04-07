//
//  CollectionUITests.swift
//  FakeNFTUITests
//
//  Created by MAKOVEY Vladislav on 07.04.2024.
//

import XCTest

final class CollectionUITests: XCTestCase {
    enum Constant {
        static let minTimeout: Double = 3
        static let baseTimeout: Double = 30
    }

    private let app = XCUIApplication()
    private lazy var page = CollectionPage(app: app)
    private lazy var catalogPage = CatalogPage(app: app)

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()

        XCTAssertTrue(catalogPage.firstCell.waitForExistence(timeout: Constant.baseTimeout))
        catalogPage.firstCell.tap()
    }

    func test_didSelectNft() {
        XCTAssertTrue(page.firstCell.waitForExistence(timeout: Constant.baseTimeout))
        page.firstCell.tap()

        XCTAssertFalse(page.screen.exists)
    }
}
