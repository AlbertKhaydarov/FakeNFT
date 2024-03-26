//
//  SplashAssembly.swift
//  FakeNFT
//
//  Created by MAKOVEY Vladislav on 19.03.2024.
//

import UIKit

final class SplashAssembly {
    // MARK: - Public

    static func assemble() -> UIViewController {
        let router = SplashRouter()
        let presenter = SplashPresenter(router: router)
        let view = SplashViewController(presenter: presenter)

        presenter.view = view

        return view
    }
}
