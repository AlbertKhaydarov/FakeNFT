//
//  CollectionPresenterTests.swift
//  FakeNFTTests
//
//  Created by MAKOVEY Vladislav on 05.04.2024.
//

@testable import FakeNFT
import XCTest

final class CollectionPresenterTests: XCTestCase {
    func test_presenterLoadAllInfo_whenViewDidLoad() {
        // arrange
        let presenter = CollectionPresenter(
            chosenItem: .fake,
            profileService: ProfileServiceStub(),
            orderService: OrderServiceStub(),
            nftService: NftServiceStub(),
            router: CollectionRouterSpy()
        )
        let view = CollectionViewSpy()
        presenter.view = view

        // act
        presenter.viewDidLoad()

        // assert
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertTrue(view.invokedShowLoader)
            XCTAssertTrue(view.invokedUpdateNfts)
            XCTAssertTrue(view.invokedDismissLoader)
        }
    }

    func test_presenterShowsError_whenProfileLoadsWithError() {
        // arrange
        let presenter = CollectionPresenter(
            chosenItem: .fake,
            profileService: ProfileServiceStub(state: .failure),
            orderService: OrderServiceStub(),
            nftService: NftServiceStub(),
            router: CollectionRouterSpy()
        )
        let view = CollectionViewSpy()
        presenter.view = view

        // act
        presenter.viewDidLoad()

        // assert
        XCTAssertTrue(view.invokedShowLoader)
        XCTAssertTrue(view.invokedShowError)
        XCTAssertTrue(view.invokedDismissLoader)

    }

    func test_presenterShowsError_whenOrderLoadsWithError() {
        // arrange
        let presenter = CollectionPresenter(
            chosenItem: .fake,
            profileService: ProfileServiceStub(),
            orderService: OrderServiceStub(state: .failure),
            nftService: NftServiceStub(),
            router: CollectionRouterSpy()
        )
        let view = CollectionViewSpy()
        presenter.view = view

        // act
        presenter.viewDidLoad()

        // assert
        XCTAssertTrue(view.invokedShowLoader)
        XCTAssertTrue(view.invokedShowError)
        XCTAssertTrue(view.invokedDismissLoader)
    }

    func test_presenterShowsError_whenNftLoadsWithError() {
        // arrange
        let presenter = CollectionPresenter(
            chosenItem: .fake,
            profileService: ProfileServiceStub(),
            orderService: OrderServiceStub(),
            nftService: NftServiceStub(state: .failure),
            router: CollectionRouterSpy()
        )
        let view = CollectionViewSpy()
        presenter.view = view

        // act
        presenter.viewDidLoad()

        // assert
        XCTAssertTrue(view.invokedShowLoader)
        XCTAssertTrue(view.invokedShowError)
        XCTAssertTrue(view.invokedDismissLoader)
    }

    func test_presenterOpenWebView_whenLinkIsTapped() {
        // arrange
        let router = CollectionRouterSpy()
        let presenter = CollectionPresenter(
            chosenItem: .fake,
            profileService: ProfileServiceStub(),
            orderService: OrderServiceStub(),
            nftService: NftServiceStub(),
            router: router
        )

        // act
        presenter.authorsLinkTapped(with: "https://test.com")

        // assert
        XCTAssertTrue(router.invokedOpenWebView)
    }

    func test_presenterNotOpenWebView_whenLinkIsEmpty() {
        // arrange
        let router = CollectionRouterSpy()
        let presenter = CollectionPresenter(
            chosenItem: .fake,
            profileService: ProfileServiceStub(),
            orderService: OrderServiceStub(),
            nftService: NftServiceStub(),
            router: router
        )

        // act
        presenter.authorsLinkTapped(with: nil)

        // assert
        XCTAssertFalse(router.invokedOpenWebView)
    }

    func test_presenterOpenDetails_whenNftSelected() {
        // arrange
        let router = CollectionRouterSpy()
        let presenter = CollectionPresenter(
            chosenItem: .fake,
            profileService: ProfileServiceStub(),
            orderService: OrderServiceStub(),
            nftService: NftServiceStub(),
            router: router
        )

        // act
        presenter.didSelectNft(id: UUID().uuidString)

        // assert
        XCTAssertTrue(router.invokedOpenNftDetal)
    }

    func test_presenterAddedLike_whenFavoriteButtonIsTappedAndStateIsActive() throws {
        // arrange
        let profileStub = ProfileServiceStub()
        let presenter = CollectionPresenter(
            chosenItem: .fake,
            profileService: profileStub,
            orderService: OrderServiceStub(),
            nftService: NftServiceStub(),
            router: CollectionRouterSpy()
        )
        let newId = UUID().uuidString

        // act
        presenter.viewDidLoad()
        presenter.favoriteButtonTapped(id: newId, state: true)

        // assert
        let actualRequestDto = try XCTUnwrap(profileStub.invokedUpdateProfileParameters?.model)
        XCTAssertTrue(profileStub.invokedUpdateProfile)
        XCTAssertTrue(actualRequestDto.likes.contains(newId))
    }

    func test_presenterRemoveLike_whenFavoriteButtonIsTappedAndStateIsNotActive() throws {
        // arrange
        let profileStub = ProfileServiceStub()
        let presenter = CollectionPresenter(
            chosenItem: .fake,
            profileService: profileStub,
            orderService: OrderServiceStub(),
            nftService: NftServiceStub(),
            router: CollectionRouterSpy()
        )
        let existingId = "1"

        // act
        presenter.viewDidLoad()
        presenter.favoriteButtonTapped(id: existingId, state: false)

        // assert
        let actualRequestDto = try XCTUnwrap(profileStub.invokedUpdateProfileParameters?.model)
        XCTAssertTrue(profileStub.invokedUpdateProfile)
        XCTAssertFalse(actualRequestDto.likes.contains(existingId))
    }

    func test_presenterAddedToCard_whenCartButtonIsTappedAndStateIsActive() throws {
        // arrange
        let orderStub = OrderServiceStub()
        let presenter = CollectionPresenter(
            chosenItem: .fake,
            profileService: ProfileServiceStub(),
            orderService: orderStub,
            nftService: NftServiceStub(),
            router: CollectionRouterSpy()
        )
        let newId = UUID().uuidString

        // act
        presenter.viewDidLoad()
        presenter.cartButtonTapped(id: newId, state: true)

        // assert
        let actualNftIds = try XCTUnwrap(orderStub.invokedUpdateOrderParameters?.nftIds)
        XCTAssertTrue(orderStub.invokedUpdateOrder)
        XCTAssertTrue(actualNftIds.contains(newId))
    }

    func test_presenterRemoveFromCard_whenCartButtonIsTappedAndStateIsNotActive() throws {
        // arrange
        let orderStub = OrderServiceStub()
        let presenter = CollectionPresenter(
            chosenItem: .fake,
            profileService: ProfileServiceStub(),
            orderService: orderStub,
            nftService: NftServiceStub(),
            router: CollectionRouterSpy()
        )
        let existingId = "1"

        // act
        presenter.viewDidLoad()
        presenter.cartButtonTapped(id: existingId, state: false)

        // assert
        let actualNftIds = try XCTUnwrap(orderStub.invokedUpdateOrderParameters?.nftIds)
        XCTAssertTrue(orderStub.invokedUpdateOrder)
        XCTAssertFalse(actualNftIds.contains(existingId))
    }
}
