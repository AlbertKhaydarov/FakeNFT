//
//  ProfileFavoritesAssembly.swift
//  FakeNFT
//
//  Created by Альберт Хайдаров on 27.03.2024.
//

import Foundation

import UIKit

final class ProfileFavoritesAssembly {

    // MARK: - Public

    static func assemble() -> UIViewController {
        let router = ProfileFavoritesRouter()
        let presenter = ProfileFavoritesPresenter(router: router)
        let view = ProfileFavoritesViewController(presenter: presenter)

        presenter.view = view
        router.viewController = view

        return view
    }
}
