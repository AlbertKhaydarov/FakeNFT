//
//  StatisticsPresenter.swift
//  FakeNFT
//
//  Created by MAKOVEY Vladislav on 19.03.2024.
//

import Foundation

protocol IStatisticsPresenter {
    func viewDidLoad()
}

final class StatisticsPresenter {
    // MARK: Properties

    weak var view: (any IStatisticsView)?
    private let router: any IStatisticsRouter

    // MARK: - Lifecycle

    init(router: some IStatisticsRouter) {
        self.router = router
    }

    // MARK: - Public

    // MARK: - Private
}

// MARK: - IStatisticsPresenter

extension StatisticsPresenter: IStatisticsPresenter {
    func viewDidLoad() { }
}
