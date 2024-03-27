//
//  ProfileRouter.swift
//  FakeNFT
//
//  Created by MAKOVEY Vladislav on 19.03.2024.
//

import UIKit

protocol ProfileRouterProtocol{
    func switchToProfileEditView(from: UIViewController)
    func switchToProfileFavoriteView()
}

final class ProfileRouter: ProfileRouterProtocol {
    
    // MARK: - Properties

    weak var viewController: UIViewController?
    
    // MARK: - Public
    func switchToProfileEditView(from: UIViewController) {
        let destination = ProfileEditAssembly.assemble()
        from.present(destination, animated: true)
    }
    
    func switchToProfileFavoriteView() {
        guard let navigationController = viewController?.navigationController else {
            assertionFailure("NavigationController is nil")
            return
        }
        
        let destination = ProfileFavoriteAssembly.assemble()
        destination.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(destination, animated: true)
    }

    // MARK: - Private
}
