//
//  SplashRouter.swift
//  FakeNFT
//
//  Created by MAKOVEY Vladislav on 19.03.2024.
//

import UIKit

protocol ISplashRouter {
    func openEntryScreen()
    func openMainScreen()
}

final class SplashRouter: ISplashRouter {
    // MARK: - Public

    func openEntryScreen() {
        // MARK: - TBD in additional part
    }

    func openMainScreen() {
        guard let window = UIApplication.shared.windows.first else {
            assertionFailure("Can't find first window")
            return
        }

        let tabBar = TabBarController()
        window.rootViewController = tabBar
        window.makeKeyAndVisible()
    }
}
