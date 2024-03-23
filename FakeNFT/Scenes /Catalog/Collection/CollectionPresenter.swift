//
//  CollectionPresenter.swift
//
//  in: FakeNFT
//  by: MAKOVEY Vladislav
//  on: 22.03.2024
//

import Foundation

protocol ICollectionPresenter {
    func viewDidLoad()
}

final class CollectionPresenter {
    // MARK: Properties

    weak var view: (any ICollectionView)?
    private let chosenItem: CollectionItem
    private let router: any ICollectionRouter

    // MARK: - Lifecycle

    init(
        chosenItem: CollectionItem,
        router: some ICollectionRouter
    ) {
        self.chosenItem = chosenItem
        self.router = router
    }

    // MARK: - Public

    // MARK: - Private
}

// MARK: - ICollectionPresenter

extension CollectionPresenter: ICollectionPresenter {
    func viewDidLoad() {
        // TODO: network call

        view?.updateCollectionItems([chosenItem])
    }
}
