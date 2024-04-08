//
//  CollectionRouter.swift
//
//  in: FakeNFT
//  by: MAKOVEY Vladislav
//  on: 22.03.2024
//

import UIKit

protocol ICollectionRouter {
    func openWebView(with url: URL)
    func openNftDetal(with id: String)
}

final class CollectionRouter: ICollectionRouter {
    // MARK: - Properties

    weak var viewController: UIViewController?

    // MARK: - Public

    func openWebView(with url: URL) {
        let destination = WebViewAssembly.assemble(with: url)
        destination.modalPresentationStyle = .fullScreen
        viewController?.present(destination, animated: true)
    }

    func openNftDetal(with id: String) {
        guard let navigationController = viewController?.navigationController else {
            assertionFailure("NavigationController is nil")
            return
        }

        let destination = NftDetailAssembly.assemble(with: .init(id: id))
        destination.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(destination, animated: true)
    }
}
