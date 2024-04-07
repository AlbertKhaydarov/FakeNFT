//
//  CatalogPage.swift
//  FakeNFTUITests
//
//  Created by MAKOVEY Vladislav on 07.04.2024.
//

import XCTest

// swiftlint:disable type_name
typealias AC = AccessibilityConstant

struct CatalogPage {
    // MARK: Dependency

    let app: XCUIApplication

    // MARK: Elements
    
    var firstCell: XCUIElement {
        app.tables.children(matching: .cell).element(boundBy: .zero)
    }

    var cellInTheMiddle: XCUIElement {
        app.tables.children(matching: .cell).element(boundBy: 2)
    }

    var sortButton: XCUIElement {
        app.buttons[AC.sortButton]
    }

    var sortingAlert: XCUIElement {
        app.otherElements[AC.sortingAlert]
    }

    var sortingButtonByName: XCUIElement {
        sortingAlert.buttons[AC.sortItemByName]
    }

    var sortingButtonByNft: XCUIElement {
        sortingAlert.buttons[AC.sortItemByNft]
    }

    // MARK: Helpers

    func labelOf(element: XCUIElement) -> String {
        element.staticTexts.element(boundBy: .zero).label
    }

    func resetSorting() {
        let start = firstCell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
        let finish = firstCell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 10))
        start.press(forDuration: 0, thenDragTo: finish)
    }
}
