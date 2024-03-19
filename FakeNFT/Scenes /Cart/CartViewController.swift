//
//  CartViewController.swift
//  FakeNFT
//
//  Created by MAKOVEY Vladislav on 19.03.2024.
//

import UIKit

protocol ICartView: AnyObject { }

final class CartViewController: UIViewController {
    // MARK: - Properties

    private let presenter: any ICartPresenter

    // MARK: - Lifecycle

    init(presenter: some ICartPresenter) {
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

// MARK: - ICartView

extension CartViewController: ICartView { }
