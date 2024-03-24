//
//  WebViewViewController.swift
//  FakeNFT
//
//  Created by MAKOVEY Vladislav on 24.03.2024.
//

import WebKit
import UIKit

protocol IWebView: AnyObject {
    func load(request: URLRequest)
}

final class WebViewViewController: UIViewController {
    private struct Constant {
        static let backButtonTopSpacing: CGFloat = 11
        static let baseInset: CGFloat = 9
    }

    // MARK: - Properties

    private let presenter: any IWebViewPresenter

    // MARK: - UI

    private lazy var webView: WKWebView = {
        let webView = WKWebView(frame: .zero)
        webView.backgroundColor = Assets.ypWhiteUniversal.color
        return webView
    }()

    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(Assets.backwardIcon.image, for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        button.tintColor = Assets.ypBlackUniversal.color
        return button
    }()

    // MARK: - Lifecycle

    init(presenter: some IWebViewPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { nil }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        presenter.viewDidLoad()
    }

    // MARK: - Private

    private func setupUI() {
        view.backgroundColor = Assets.ypWhiteUniversal.color

        backButton.placedOn(view)
        NSLayoutConstraint.activate([
            backButton.top.constraint(equalTo: view.safeTop, constant: Constant.backButtonTopSpacing),
            backButton.left.constraint(equalTo: view.left, constant: Constant.baseInset)
        ])

        webView.placedOn(view)
        NSLayoutConstraint.activate([
            webView.top.constraint(equalTo: backButton.bottom, constant: Constant.baseInset),
            webView.left.constraint(equalTo: view.left),
            webView.right.constraint(equalTo: view.right),
            webView.bottom.constraint(equalTo: view.bottom)
        ])
    }

    @objc
    private func backButtonTapped() {
        dismiss(animated: true)
    }
}

// MARK: - IWebView

extension WebViewViewController: IWebView {
    func load(request: URLRequest) {
        webView.load(request)
    }
}
