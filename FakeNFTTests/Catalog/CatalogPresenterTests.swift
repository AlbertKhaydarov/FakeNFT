//
//  CatalogPresenterTests.swift
//  FakeNFTTests
//
//  Created by MAKOVEY Vladislav on 03.04.2024.
//

@testable import FakeNFT
import XCTest

final class CatalogPresenterTests: XCTestCase {
    func test_presenterLoadCatalogItems_whenViewDidLoad() {
        // arrange
        let presenter = CatalogPresenter(
            router: CatalogRouterSpy(),
            service: CatalogItemServiceStub(),
            sortStorage: SortStorageStub()
        )

        let view = CatalogViewSpy()
        presenter.view = view

        // act
        presenter.viewDidLoad()

        // assert
        XCTAssertTrue(view.invokedShowLoader)
        XCTAssertTrue(view.invokedUpdateCatalogItems)
        XCTAssertTrue(view.invokedDismissLoader)
    }

    func test_presenterShowsError_whenItemsLoadsWithError() {
        // arrange
        let presenter = CatalogPresenter(
            router: CatalogRouterSpy(),
            service: CatalogItemServiceStub(state: .failure),
            sortStorage: SortStorageStub()
        )

        let view = CatalogViewSpy()
        presenter.view = view

        // act
        presenter.viewDidLoad()

        // assert
        XCTAssertTrue(view.invokedShowLoader)
        XCTAssertTrue(view.invokedShowError)
        XCTAssertTrue(view.invokedDismissLoader)
    }

    func test_presenterLoadItems_whenPullToRefreshDragged() {
        // arrange
        let presenter = CatalogPresenter(
            router: CatalogRouterSpy(),
            service: CatalogItemServiceStub(),
            sortStorage: SortStorageStub()
        )

        let view = CatalogViewSpy()
        presenter.view = view

        // act
        presenter.pullToRefreshDragged()

        // assert
        XCTAssertTrue(view.invokedShowLoader)
        XCTAssertTrue(view.invokedUpdateCatalogItems)
        XCTAssertTrue(view.invokedDismissLoader)
    }

    func test_presenterShowsAlert_whenSortButtonTapped() {
        // arrange
        let presenter = CatalogPresenter(
            router: CatalogRouterSpy(),
            service: CatalogItemServiceStub(),
            sortStorage: SortStorageStub()
        )

        let view = CatalogViewSpy()
        presenter.view = view

        // act
        presenter.sortButtonTapped()

        // assert
        XCTAssertTrue(view.invokedShowSortingAlert)
    }

}
