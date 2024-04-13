//
//  ProfileRouterSpy.swift
//  FakeNFTTests
//
//  Created by Альберт Хайдаров on 08.04.2024.
//

@testable import FakeNFT
import Foundation
import UIKit

final class ProfileRouterSpy: ProfileRouterProtocol {
    let viewController = ProfileViewControllerSpy()
    var invokedSwitchToProfileEditView = false
    var invokedSwitchToProfileEditViewCount = 0
    var invokedSwitchToProfileEditViewParameters: (destination: UIViewController, profile: ProfileViewModel)?

    func switchToProfileEditView(destination: UIViewController, profile: ProfileViewModel) {
        invokedSwitchToProfileEditView = true
        invokedSwitchToProfileEditViewCount += 1
        invokedSwitchToProfileEditViewParameters = (destination: destination, profile: profile)
    }

    var invokedSwitchToProfileMyNFTView = false
    var invokedSwitchToProfileMyNFTViewCount = 0

    func switchToProfileMyNFTView() {
        invokedSwitchToProfileMyNFTView = false
        invokedSwitchToProfileMyNFTViewCount += 1
    }

    var invokedSwitchToProfileFavoriteView = false
    var invokedSwitchToProfileFavoriteViewCount = 0

    func switchToProfileFavoriteView() {
        invokedSwitchToProfileFavoriteView = false
        invokedSwitchToProfileFavoriteViewCount += 1
    }

    var invokedSwitchToWebView = false
    var invokedSwitchToWebViewCount = 0
    var invokedSwitchToWebViewParameters: (url: URL, Void)?
    var invokedSwitchToViewViewParametersList = [(url: URL, Void)]()

    func switchToProfileUserWebViewViewController(with url: URL) {
        invokedSwitchToWebView = true
        invokedSwitchToWebViewCount += 1
        invokedSwitchToWebViewParameters = (url, ())
        invokedSwitchToViewViewParametersList.append((url, ()))
    }
}
