//
//  ProfileFavoriteAssembly.swift
//  FakeNFT
//
//  Created by Альберт Хайдаров on 26.03.2024.
//

import UIKit

final class ProfileFavoriteAssembly {
 
    // MARK: - Public

    static func assemble() -> UIViewController {
        let router = ProfileFavoriteRouter()
        let presenter = ProfileFavoritePresenter(router: router)
        let view = ProfileFavoriteViewController(presenter: presenter)

        presenter.view = view
        router.viewController = view
        
        return view
    }
}
