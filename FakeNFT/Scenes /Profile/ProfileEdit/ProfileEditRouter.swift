//
//  ProfileEditRouter.swift
//  FakeNFT
//
//  Created by Альберт Хайдаров on 25.03.2024.
//

import UIKit

protocol ProfileEditRouterProtocol {
    func switchToProfileMainViewViewController()
}

final class ProfileEditRouter: ProfileEditRouterProtocol {

    // MARK: - Properties
    weak var viewController: UIViewController?
    
    func switchToProfileMainViewViewController() {
//        viewController?.dismiss(animated: true)
    }
}
