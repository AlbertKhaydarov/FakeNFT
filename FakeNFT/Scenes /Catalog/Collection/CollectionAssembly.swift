//
//  CollectionAssembly.swift
//
//  in: FakeNFT
//  by: MAKOVEY Vladislav
//  on: 22.03.2024
//

import UIKit

final class CollectionAssembly {
    // MARK: - Public

    static func assemble(collectionItem: CatalogItem) -> UIViewController {
        let router = CollectionRouter()
        let presenter = CollectionPresenter(chosenItem: collectionItem, router: router)
        let view = CollectionViewController(
            presenter: presenter,
            layoutProvider: CollectionLayoutProvider()
        )

        presenter.view = view
        router.viewController = view

        return view
    }
}
