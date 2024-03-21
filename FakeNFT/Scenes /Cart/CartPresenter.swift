//
//  CartPresenter.swift
//  FakeNFT
//
//  Created by MAKOVEY Vladislav on 19.03.2024.
//

import Foundation

protocol ICartPresenter {
    func viewDidLoad()
}

final class CartPresenter {
    // MARK: Properties

    weak var view: (any ICartView)?
    private let router: any ICartRouter

    // MARK: - Lifecycle

    init(router: some ICartRouter) {
        self.router = router
    }

    // MARK: - Public

    // MARK: - Private
}

// MARK: - ICartPresenter

extension CartPresenter: ICartPresenter {
    func viewDidLoad() { }
}
