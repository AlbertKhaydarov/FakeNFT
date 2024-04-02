//
//  StatisticsViewController.swift
//  FakeNFT
//
//  Created by MAKOVEY Vladislav on 19.03.2024.
//

import UIKit

protocol IStatisticsView: AnyObject { }

final class StatisticsViewController: UIViewController {
    // MARK: - Properties

    private let presenter: any IStatisticsPresenter

    // MARK: - Lifecycle

    init(presenter: some IStatisticsPresenter) {
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

// MARK: - IStatisticsView

extension StatisticsViewController: IStatisticsView { }
