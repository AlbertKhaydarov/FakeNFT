//
//  ProfileUserWebViewAssembly.swift
//  FakeNFT
//
//  Created by Альберт Хайдаров on 27.03.2024.
//

import UIKit

final class ProfileUserWebViewAssembly {
    // MARK: - Public

    static func assemble(with url: URL) -> UIViewController {
        let presenter = ProfileUserWebViewPresenter(url: url)
        let view = ProfileUserWebViewViewController(presenter: presenter)

        presenter.view = view
        return view
    }
}

