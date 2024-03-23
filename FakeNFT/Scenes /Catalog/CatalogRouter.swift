//
//  CatalogRouter.swift
//  FakeNFT
//
//  Created by MAKOVEY Vladislav on 19.03.2024.
//

import UIKit

protocol ICatalogRouter {
    func openCollectionScreen(with item: CollectionItem)
}

final class CatalogRouter: ICatalogRouter {
    // MARK: - Properties

    weak var viewController: UIViewController?

    // MARK: - Public

    func openCollectionScreen(with item: CollectionItem) {
        guard let navigationController = viewController?.navigationController else {
            assertionFailure("NavigationController is nil")
            return
        }

        let destination = CollectionAssembly.assemble(collectionItem: item)
        destination.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(destination, animated: true)
    }

    // MARK: - Private
}
