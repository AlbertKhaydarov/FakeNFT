//
//  CatalogAssembly.swift
//  FakeNFT
//
//  Created by MAKOVEY Vladislav on 19.03.2024.
//

import UIKit

final class CatalogAssembly {
    // MARK: - Public

    static func assemble() -> UIViewController {
        let service: ICatalogItemService = CatalogItemService(networkClient: DefaultNetworkClient())

        let router = CatalogRouter()
        let presenter = CatalogPresenter(router: router, service: service)
        let view = CatalogViewController(presenter: presenter)

        presenter.view = view
        router.viewController = view

        return view
    }
}
