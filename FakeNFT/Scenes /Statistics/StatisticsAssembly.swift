//
//  StatisticsAssembly.swift
//  FakeNFT
//
//  Created by MAKOVEY Vladislav on 19.03.2024.
//

import UIKit

final class StatisticsAssembly {
    // MARK: - Public

    static func assemble() -> UIViewController {
        let router = StatisticsRouter()
        let presenter = StatisticsPresenter(router: router)
        let view = StatisticsViewController(presenter: presenter)

        presenter.view = view

        return view
    }
}
