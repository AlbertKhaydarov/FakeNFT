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
        let servicesAssembler = ServicesAssembly( networkClient: DefaultNetworkClient(),
                                                  nftStorage: NftStorageImpl() )

        let router = ProfileMyNFTRouter()
        let presenter = ProfileMyNFTPresenter(router: router,
                                              service: servicesAssembler.profileMyNFTService)
        let view = ProfileMyNFTViewController(presenter: presenter)

        presenter.view = view
        router.viewController = view

        return view
    }
}
