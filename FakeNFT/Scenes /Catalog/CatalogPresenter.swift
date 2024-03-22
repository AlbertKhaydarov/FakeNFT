//
//  CatalogPresenter.swift
//  FakeNFT
//
//  Created by MAKOVEY Vladislav on 19.03.2024.
//

import Foundation

protocol ICatalogPresenter {
    func viewDidLoad()
}

final class CatalogPresenter {
    // MARK: Properties

    weak var view: (any ICatalogView)?
    private let router: any ICatalogRouter

    // MARK: - Lifecycle

    init(router: some ICatalogRouter) {
        self.router = router
    }

    // MARK: - Public

    // MARK: - Private
}

// MARK: - ICatalogPresenter

extension CatalogPresenter: ICatalogPresenter {
    func viewDidLoad() {
        // TODO: network call

        let mockCollectionItems: [CollectionItem] = [
            CollectionItem.makeMockCollectionItem(with: "Peach"),
            CollectionItem.makeMockCollectionItem(with: "Blue"),
            CollectionItem.makeMockCollectionItem(with: "Brown"),
            CollectionItem.makeMockCollectionItem(with: "White")
        ]

        view?.updateCollectionItems(mockCollectionItems)
    }
}
