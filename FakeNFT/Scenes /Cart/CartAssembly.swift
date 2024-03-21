//
//  CartAssembly.swift
//  FakeNFT
//
//  Created by MAKOVEY Vladislav on 19.03.2024.
//

import UIKit

final class CartAssembly {
    // MARK: - Public

    static func assemble() -> UIViewController {
        let router = CartRouter()
        let presenter = CartPresenter(router: router)
        let view = CartViewController(presenter: presenter)

        presenter.view = view

        return view
    }
}
