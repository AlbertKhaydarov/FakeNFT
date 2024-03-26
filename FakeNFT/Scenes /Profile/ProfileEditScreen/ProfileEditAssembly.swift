//
//  ProfileEditAssembly.swift
//  FakeNFT
//
//  Created by Альберт Хайдаров on 25.03.2024.
//

import UIKit

final class ProfileEditAssembly {
 
    // MARK: - Public

    static func assemble() -> UIViewController {
        let router = ProfileEditRouter()
        let presenter = ProfileEditPresenter(router: router)
        let view = ProfileEditViewController(presenter: presenter)

        presenter.view = view

        return view
    }
}



