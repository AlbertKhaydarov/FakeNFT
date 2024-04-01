//
//  ProfileUserWebViewViewController.swift
//  FakeNFT
//
//  Created by Альберт Хайдаров on 27.03.2024.
//

import UIKit
import WebKit

protocol ProfileUserWebViewViewControllerProtocol: AnyObject {
    func load(request: URLRequest)
    func setProgressValue(_ newValue: Float)
    func setProgressHidden(_ isHidden: Bool)
}

class ProfileUserWebViewViewController: UIViewController {

    // MARK: - Properties
    private let presenter: any ProfileUserWebViewPresenterProtocol

    private var estimatedProgressObservation: NSKeyValueObservation?

    private lazy var webView: WKWebView = {
        let webView = WKWebView(frame: .zero)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.backgroundColor = Assets.ypWhiteUniversal.color
        return webView
    }()

    private lazy var progressView: UIProgressView = {
        let view = UIProgressView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Assets.ypLightGrey.color
        view.tintColor = Assets.ypBlack.color
        return view
    }()

    private lazy var backwardButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(Assets.backwardIcon.image, for: .normal)
        button.addTarget(self, action: #selector(backwardButtonTapped), for: .touchUpInside)
        button.tintColor = Assets.ypBlack.color
        return button
    }()

    init(presenter: some ProfileUserWebViewPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { nil }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        setupSubview()
        layoutSubviews()

        estimatedProgressObservation = webView.observe(
            \.estimatedProgress,
             options: [],
             changeHandler: { [weak self] _, _ in
                 guard let self = self else { return }
                 presenter.didUpdateProgressValue(webView.estimatedProgress)
             })
    }

    @objc private func backwardButtonTapped() {
        dismiss(animated: true)
    }

    private func setupSubview() {
        view.backgroundColor = Assets.ypWhiteUniversal.color
        view.addSubview(webView)
        view.addSubview(backwardButton)
        view.addSubview(progressView)
    }

    private func layoutSubviews() {
        NSLayoutConstraint.activate([
            backwardButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 11),
            backwardButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 9),

            webView.topAnchor.constraint(equalTo: backwardButton.bottomAnchor, constant: 9),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            progressView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 44 )
        ])
    }
}

// MARK: - ProfileUserWebViewViewControllerProtocol

extension ProfileUserWebViewViewController: ProfileUserWebViewViewControllerProtocol {
    func load(request: URLRequest) {
        webView.load(request)
    }

    func setProgressValue(_ newValue: Float) {
        progressView.progress = newValue
    }

    func setProgressHidden(_ isHidden: Bool) {
        progressView.isHidden = isHidden
    }
}
