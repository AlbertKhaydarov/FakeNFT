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

    static func assemble() -> UIViewController {
        let router = CollectionRouter()
        let presenter = CollectionPresenter(router: router)
        let view = CollectionViewController(presenter: presenter)

        presenter.view = view

        return view
    }
}
