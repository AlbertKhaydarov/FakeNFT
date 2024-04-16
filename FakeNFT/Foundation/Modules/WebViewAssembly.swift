//
//  WebViewAssembly.swift
//  FakeNFT
//
//  Created by MAKOVEY Vladislav on 24.03.2024.
//

import UIKit

final class WebViewAssembly {
    // MARK: - Public

    static func assemble(with url: URL) -> UIViewController {
        let presenter = WebViewPresenter(url: url)
        let view = WebViewViewController(presenter: presenter)

        presenter.view = view

        return view
    }
}
