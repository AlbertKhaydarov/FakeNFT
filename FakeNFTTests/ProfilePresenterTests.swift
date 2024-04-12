//
//  ProfilePresenterTests.swift
//  FakeNFTTests
//
//  Created by Альберт Хайдаров on 09.04.2024.
//

@testable import FakeNFT
import XCTest

final class ProfilePresenterTests: XCTestCase {

    func testingProfilePresenterLoadAllInfoWhenViewDidLoad() {
        // arrange
        let presenter = ProfilePresenter(router: ProfileRouterSpy(),
                                         service: ProfileServiceStub())
        let view = ProfileViewControllerSpy()

        presenter.view = view

        // act
        presenter.viewDidLoad()

        // assert
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertTrue(view.invokedUpdateProfile)
        }
    }
}
