//
//  ProfileAssembly.swift
//  FakeNFT
//
//  Created by MAKOVEY Vladislav on 19.03.2024.
//

import UIKit

final class ProfileAssembly {

    // MARK: - Public

    static func assemble() -> (UIViewController) {
        let router = ProfileRouter()

        let servicesAssembler = ServicesAssembly( networkClient: DefaultNetworkClient(),
                                                  nftStorage: NftStorageImpl() )

        let presenter = ProfilePresenter(router: router, service: servicesAssembler.profileService)
        let view = ProfileViewController(presenter: presenter)

        presenter.view = view
        router.viewController = view

        return (view)
    }
}
