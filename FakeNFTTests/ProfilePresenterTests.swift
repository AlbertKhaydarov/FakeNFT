//
//  ProfilePresenterTests.swift
//  FakeNFTTests
//
//  Created by Альберт Хайдаров on 08.04.2024.
//

@testable import FakeNFT
import XCTest

final class ProfilePresenterTests: XCTestCase {

    func testingProfilePresenterLoadAllInfoWhenViewDidLoad() {
        let presenter = ProfilePresenter(router: ProfileRouterSpy(),
                                         service: ProfileServiceStub())
    }
}
