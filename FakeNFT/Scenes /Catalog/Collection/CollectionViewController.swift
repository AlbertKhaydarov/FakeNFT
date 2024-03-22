//
//  CollectionViewController.swift
//
//  in: FakeNFT
//  by: MAKOVEY Vladislav
//  on: 22.03.2024
//

import UIKit

protocol ICollectionView: AnyObject { }

final class CollectionViewController: UIViewController {
    // MARK: - Properties

    private let presenter: any ICollectionPresenter

    // MARK: - Lifecycle

    init(presenter: some ICollectionPresenter) {
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

// MARK: - ICollectionView

extension CollectionViewController: ICollectionView { }
