//
//  ProfileRouterSpy.swift
//  FakeNFTTests
//
//  Created by Альберт Хайдаров on 08.04.2024.
//

@testable import FakeNFT
import Foundation
// swiftlint:disable all
final class ProfileRouterSpy: ICollectionRouter {
    let viewController = ProfileViewControllerSpy()
    var invokedSwitchToProfileEditView = false
    var invokedSwitchToProfileEditViewCount = 0
    var invokedSwitchToProfileEditViewParameters: (destination: UIViewController, profile: ProfileViewModel, Void)?
    var invokedSwitchToProfileEditViewParametersList = [(destination: UIViewController, profile: ProfileViewModel,  Void)]()
    
    func switchToProfileEditView(destination: viewController, profile: ProfileViewModel) {
        invokedSwitchToProfileEditView = true
        invokedSwitchToProfileEditViewCount += 1
        invokedSwitchToProfileEditViewParameters = (destination: destination, profile: profile, ())
        invokedSwitchToProfileEditViewParametersList.append((destination: destination, profile: profile, ()))
    }
    
    var invokedSwitchToProfileMyNFTView = false
    var invokedSwitchToProfileMyNFTViewCount = 0
    var invokedSwitchToProfileMyNFTViewParameters: (Void)?
    var invokedSwitchToProfileMyNFTViewParametersList = [(Void)]()
    
    func switchToProfileMyNFTView() {
        invokedSwitchToProfileMyNFTView = false
        invokedSwitchToProfileMyNFTViewCount = 0
        invokedSwitchToProfileMyNFTViewParameters: (Void)?
        invokedSwitchToProfileMyNFTViewParametersList = [(Void)]()
    }
    
    var invokedSwitchToProfileFavoriteView = false
    var invokedSwitchToProfileFavoriteViewCount = 0
    var invokedSwitchToProfileFavoriteViewParameters: (Void)?
    var invokedSwitchToPProfileFavoriteViewParametersList = [(Void)]()
    
    func switchToProfileFavoriteView() {
        invokedSwitchToProfileFavoriteView = false
        invokedSwitchToProfileFavoriteViewCount = 0
        invokedSwitchToProfileFavoriteViewParameters: (Void)?
        invokedSwitchToPProfileFavoriteViewParametersList = [(Void)]()
    }
    
    var invokedSwitchToProfileUserWebViewViewController = false
    var invokedSwitchToProfileUserWebViewViewControllerCount = 0
    var invokedSwitchToProfileUserWebViewViewControllerParameters: (url: URL, Void)?
    var invokedSwitchToProfileUserWebViewViewControllerParametersList = [(url: URL, Void)]()
    
    func switchToProfileUserWebViewViewController(with url: URL) {
        invokedSwitchToProfileUserWebViewViewController = true
        invokedSwitchToProfileUserWebViewViewControllerCount += 1
        invokedSwitchToProfileUserWebViewViewControllerParameters = (url, ())
        invokedSwitchToProfileUserWebViewViewControllerParametersList.append((url, ()))
    }
}
