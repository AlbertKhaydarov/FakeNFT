//
//  SplashViewController.swift
//  FakeNFT
//
//  Created by MAKOVEY Vladislav on 19.03.2024.
//

import UIKit

protocol ISplashView: AnyObject { }

final class SplashViewController: UIViewController {
    // MARK: - Properties

    private let presenter: any ISplashPresenter

    // MARK: - Lifecycle

    init(presenter: some ISplashPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { nil }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    

}

// MARK: - ISplashView

extension SplashViewController: ISplashView { }
