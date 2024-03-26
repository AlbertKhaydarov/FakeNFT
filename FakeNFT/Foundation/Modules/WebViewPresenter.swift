//
//  WebViewPresenter.swift
//  FakeNFT
//
//  Created by MAKOVEY Vladislav on 24.03.2024.
//

import Foundation

protocol IWebViewPresenter {
    func viewDidLoad()
}

final class WebViewPresenter {
    // MARK: Properties

    weak var view: (any IWebView)?
    private let url: URL

    // MARK: - Lifecycle

    init(url: URL) {
        self.url = url
    }
}

// MARK: - IWebViewPresenter

extension WebViewPresenter: IWebViewPresenter {
    func viewDidLoad() {
        let request = URLRequest(url: url)
        view?.load(request: request)
    }
}
