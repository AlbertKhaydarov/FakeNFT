//
//  CatalogUITests.swift
//  FakeNFTUITests
//
//  Created by MAKOVEY Vladislav on 06.04.2024.
//

import XCTest

final class CatalogUITests: XCTestCase {
    enum Constant {
        static let minTimeout: Double = 3
        static let baseTimeout: Double = 30
    }

    private let app = XCUIApplication()
    private lazy var page = CatalogPage(app: app)

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
        app.tabBars.buttons.element(boundBy: 1).tap()
    }

    func test_catalogSortingByName() {
        XCTAssertTrue(page.firstCell.waitForExistence(timeout: Constant.baseTimeout))
        let beforeSortingLabel = page.labelOf(element: page.firstCell)

        page.sortButton.tap()

        let alert = page.sortingAlert
        XCTAssertTrue(alert.exists)

        page.sortingButtonByName.tap()

        let afterSortingLabel = page.labelOf(element: page.firstCell)

        XCTAssertNotEqual(
            beforeSortingLabel,
            afterSortingLabel
        )

        page.resetSorting()
    }

    func test_catalogSortingByNft() {
        XCTAssertTrue(page.cellInTheMiddle.waitForExistence(timeout: Constant.baseTimeout))
        let beforeSortingLabel = page.labelOf(element: page.cellInTheMiddle)

        page.sortButton.tap()

        let alert = page.sortingAlert
        XCTAssertTrue(alert.exists)

        page.sortingButtonByNft.tap()

        let afterSortingLabel = page.labelOf(element: page.firstCell)

        XCTAssertNotEqual(
            beforeSortingLabel,
            afterSortingLabel
        )

        page.resetSorting()
    }

    func test_didSelectCell() {
        XCTAssertTrue(page.firstCell.waitForExistence(timeout: Constant.baseTimeout))
        page.firstCell.tap()

        XCTAssertFalse(page.screen.exists)
    }
}
