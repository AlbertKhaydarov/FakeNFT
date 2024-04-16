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
        let servicesAssembler = ServicesAssembly( networkClient: DefaultNetworkClient(),
                                                  nftStorage: NftStorageImpl() )
        let router = ProfileFavoritesRouter()
        let presenter = ProfileFavoritesPresenter(router: router,
                                                  service: servicesAssembler.profileMyNFTService)
        let view = ProfileFavoritesViewController(presenter: presenter)

        presenter.view = view
        router.viewController = view

        return view
    }
}
