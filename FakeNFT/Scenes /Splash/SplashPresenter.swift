//
//  SplashPresenter.swift
//  FakeNFT
//
//  Created by MAKOVEY Vladislav on 19.03.2024.
//

import Foundation

protocol ISplashPresenter {
    func viewDidLoad()
}

final class SplashPresenter {
    // MARK: Properties

    weak var view: (any ISplashView)?
    private let router: any ISplashRouter

    // MARK: - Lifecycle

    init(router: some ISplashRouter) {
        self.router = router
    }
}

// MARK: - ISplashPresenter

extension SplashPresenter: ISplashPresenter {
    func viewDidLoad() {
        router.openMainScreen()
    }
}
