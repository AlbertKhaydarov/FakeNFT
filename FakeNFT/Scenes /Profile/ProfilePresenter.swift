//
//  ProfilePresenter.swift
//  FakeNFT
//
//  Created by MAKOVEY Vladislav on 19.03.2024.
//

import UIKit

protocol ProfilePresenterProtocol {
    func viewDidLoad()
    var countTitleButtons: [Int] { get } 
//    func createButton(with title: String) -> UIButton
}

final class ProfilePresenter {
    // MARK: Properties

    weak var view: (any ProfileViewProtocol)?
    private let router: any ProfileRouterProtocol
//    private var factoryButton: any ProfileButtonFactoryProtocol

    var countTitleButtons: [Int] = [112, 11, 64]
    // MARK: - Lifecycle

    init(router: some ProfileRouterProtocol) {
        self.router = router
//        factoryButton = ProfileButtonFactory()
    }

    // MARK: - Public

    // MARK: - Private
}

// MARK: - IProfilePresenter

extension ProfilePresenter: ProfilePresenterProtocol {
//    func createButton(with title: String) -> UIButton {
//        factoryButton.createButton(with: title)
//    }
    
    func viewDidLoad() {
    }
}
