//
//  ProfileFavoriteAssembly.swift
//  FakeNFT
//
//  Created by Альберт Хайдаров on 26.03.2024.
//

import UIKit

final class ProfileMyNFTAssembly {
 
    // MARK: - Public

    static func assemble() -> UIViewController {
        let router = ProfileMyNFTRouter()
        let presenter = ProfileMyNFTPresenter(router: router)
        let view = ProfileMyNFTViewController(presenter: presenter)

        presenter.view = view
        router.viewController = view
        
        return view
    }
}
