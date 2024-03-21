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
        let router = CatalogRouter()
        let presenter = CatalogPresenter(router: router)
        let view = CatalogViewController(presenter: presenter)

        presenter.view = view

        return view
    }
}
