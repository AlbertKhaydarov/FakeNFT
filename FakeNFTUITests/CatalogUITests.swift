//
//  CatalogUITests.swift
//  FakeNFTUITests
//
//  Created by MAKOVEY Vladislav on 06.04.2024.
//

import XCTest

// swiftlint:disable type_name
typealias AC = AccessibilityConstant

final class CatalogUITests: XCTestCase {
    enum Constant {
        static let minTimeout: Double = 3
        static let baseTimeout: Double = 30
    }

    private let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    func test_catalogSortingByName() {
        let tables = app.tables
        let cellBeforeSorting = tables.children(matching: .cell).element(boundBy: .zero)
        XCTAssertTrue(cellBeforeSorting.waitForExistence(timeout: Constant.baseTimeout))
        let beforeSortingLabel = cellBeforeSorting.staticTexts.element(boundBy: .zero).label

        app.buttons[AC.sortButton].tap()

        let alert = app.otherElements[AC.sortingAlert]
        XCTAssertTrue(alert.exists)

        alert.buttons[AC.sortItemByName].tap()

        let cellAfterSorting = tables.children(matching: .cell).element(boundBy: .zero)
        let afterSortingLabel = cellAfterSorting.staticTexts.element(boundBy: .zero).label

        XCTAssertNotEqual(
            beforeSortingLabel,
            afterSortingLabel
        )

        resetSorting()
    }

    func test_catalogSortingByNft() {
        let tables = app.tables
        let cellBeforeSorting = tables.children(matching: .cell).element(boundBy: 2)
        XCTAssertTrue(cellBeforeSorting.waitForExistence(timeout: Constant.baseTimeout))
        let beforeSortingLabel = cellBeforeSorting.staticTexts.element(boundBy: .zero).label

        app.buttons[AC.sortButton].tap()

        let alert = app.otherElements[AC.sortingAlert]
        XCTAssertTrue(alert.exists)

        alert.buttons[AC.sortItemByNft].tap()

        let cellAfterSorting = tables.children(matching: .cell).element(boundBy: .zero)
        let afterSortingLabel = cellAfterSorting.staticTexts.element(boundBy: .zero).label

        XCTAssertNotEqual(
            beforeSortingLabel,
            afterSortingLabel
        )

        resetSorting()
    }

    func test_didSelectCell() {
        let tables = app.tables
        let firstCell = tables.children(matching: .cell).element(boundBy: .zero)
        XCTAssertTrue(firstCell.waitForExistence(timeout: Constant.baseTimeout))
        firstCell.tap()

        XCTAssertFalse(firstCell.exists)
    }

    private func resetSorting() {
        let firstCell = app.tables.children(matching: .cell).element(boundBy: .zero)
        let start = firstCell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
        let finish = firstCell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 10))
        start.press(forDuration: 0, thenDragTo: finish)
    }
}
