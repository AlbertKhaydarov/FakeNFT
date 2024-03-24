//
//  CatalogPresenter.swift
//  FakeNFT
//
//  Created by MAKOVEY Vladislav on 19.03.2024.
//

import Foundation

protocol ICatalogPresenter {
    func viewDidLoad()

    func sortButtonTapped()
    func sortByNameChosen()
    func sortByQuantityChosen()

    func cellDidSelected(with item: CollectionItem)
}

final class CatalogPresenter {
    // MARK: Properties

    weak var view: (any ICatalogView)?
    private let router: any ICatalogRouter
    private var collectionItems = [CollectionItem]()

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

        collectionItems = [
            CollectionItem.makeMockCollectionItem(with: "Peach", quantity: ["1"]),
            CollectionItem.makeMockCollectionItem(with: "Blue", quantity: ["1", "2", "3", "4"]),
            CollectionItem.makeMockCollectionItem(with: "Brown", quantity: ["1", "2", "3"]),
            CollectionItem.makeMockCollectionItem(with: "White", quantity: ["1", "2", "3", "4", "5"])
        ]

        view?.updateCollectionItems(collectionItems)
    }

    func sortButtonTapped() {
        view?.showSortingAlert()
    }

    func sortByNameChosen() {
        collectionItems.sort(by: { $0.name < $1.name })
        view?.updateCollectionItems(collectionItems)
    }

    func sortByQuantityChosen() {
        collectionItems.sort(by: { $0.nfts.count < $1.nfts.count })
        view?.updateCollectionItems(collectionItems)
    }

    func cellDidSelected(with item: CollectionItem) {
        router.openCollectionScreen(with: item)
    }
}
