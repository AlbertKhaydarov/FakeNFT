//
//  ProfileRouter.swift
//  FakeNFT
//
//  Created by MAKOVEY Vladislav on 19.03.2024.
//

import UIKit

protocol ProfileRouterProtocol{
    func switchToProfileEditView(from: UIViewController)
}

final class ProfileRouter: ProfileRouterProtocol {
    
    // MARK: - Properties

//    weak var viewController: UIViewController?
    
    // MARK: - Public
    func switchToProfileEditView(from: UIViewController) {
//        guard let navigationController = viewController?.navigationController else {
//            assertionFailure("NavigationController is nil")
//            return
//        }
        let destination = ProfileEditAssembly.assemble()
        from.present(destination, animated: true)
    }
    // MARK: - Private
}
