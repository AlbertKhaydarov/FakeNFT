//
//  CatalogViewController.swift
//  FakeNFT
//
//  Created by MAKOVEY Vladislav on 19.03.2024.
//

import UIKit

protocol ICatalogView: AnyObject { }

final class CatalogViewController: UIViewController {
    // MARK: - Properties

    private let presenter: any ICatalogPresenter

    // MARK: - Lifecycle

    init(presenter: some ICatalogPresenter) {
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

// MARK: - ICatalogView

extension CatalogViewController: ICatalogView { }
