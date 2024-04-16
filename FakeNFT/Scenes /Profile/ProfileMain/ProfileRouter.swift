//
//  ProfileRouter.swift
//  FakeNFT
//
//  Created by MAKOVEY Vladislav on 19.03.2024.
//

import UIKit

protocol ProfileRouterProtocol {
    func switchToProfileEditView(destination: UIViewController, profile: ProfileViewModel)
    func switchToProfileMyNFTView()
    func switchToProfileFavoriteView()
    func switchToProfileUserWebViewViewController(with url: URL)
}

final class ProfileRouter: ProfileRouterProtocol {

    // MARK: - Properties

    weak var viewController: UIViewController?

    // MARK: - Public
    func switchToProfileEditView(destination: UIViewController, profile: ProfileViewModel) {
        viewController?.present(destination, animated: true)
    }

    func switchToProfileMyNFTView() {
        guard let navigationController = viewController?.navigationController else {
            assertionFailure("NavigationController is nil")
            return
        }
        let destination = ProfileMyNFTAssembly.assemble()
        destination.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(destination, animated: true)
    }

    func switchToProfileFavoriteView() {
        guard let navigationController = viewController?.navigationController else {
            assertionFailure("NavigationController is nil")
            return
        }
        let destination = ProfileFavoritesAssembly.assemble()
        destination.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(destination, animated: true)
    }

    func switchToProfileUserWebViewViewController(with url: URL) {
        let destination = ProfileUserWebViewAssembly.assemble(with: url)
        destination.modalPresentationStyle = .fullScreen
        viewController?.present(destination, animated: true)
    }
}
