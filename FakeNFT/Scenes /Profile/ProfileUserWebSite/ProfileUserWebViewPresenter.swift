//
//  ProfileUserWebView.swift
//  FakeNFT
//
//  Created by Альберт Хайдаров on 27.03.2024.
//

import Foundation

protocol ProfileUserWebViewPresenterProtocol {
    func didUpdateProgressValue(_ newValue: Double)
    func viewDidLoad()
}

final class ProfileUserWebViewPresenter {

    // MARK: Properties
    weak var view: (any ProfileUserWebViewViewControllerProtocol)?

    private let url: URL

    init(url: URL) {
        self.url = url
    }

    // MARK: - Public
    func didUpdateProgressValue(_ newValue: Double) {
        let newProgressValue = Float(newValue)
        view?.setProgressValue(newProgressValue)
        let shouldHideProgress = shouldHideProgress(for: newProgressValue)
        view?.setProgressHidden(shouldHideProgress)
    }

    func shouldHideProgress(for value: Float) -> Bool {
        abs(value - 1.0) <= 0.0001
    }
}

// MARK: - ProfileUserWebViewPresenterProtocol

extension ProfileUserWebViewPresenter: ProfileUserWebViewPresenterProtocol {
    func viewDidLoad() {
        let request = URLRequest(url: url)
        view?.load(request: request)
    }
}
