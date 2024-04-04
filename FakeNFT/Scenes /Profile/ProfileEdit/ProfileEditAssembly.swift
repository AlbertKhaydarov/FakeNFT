//
//  ProfileEditAssembly.swift
//  FakeNFT
//
//  Created by Альберт Хайдаров on 25.03.2024.
//

import UIKit

final class ProfileEditAssembly {

    // MARK: - Public

    static func assemble(profile: ProfileViewModel) -> UIViewController {
        let router = ProfileEditRouter()
        let servicesAssembler = ServicesAssembly( networkClient: DefaultNetworkClient(),
                                                  nftStorage: NftStorageImpl() )

        let presenter = ProfileEditPresenter(router: router, profile: profile, service: servicesAssembler.profileService)
        let view = ProfileEditViewController(presenter: presenter)

        presenter.view = view
        router.viewController = view
        return view
    }
}
