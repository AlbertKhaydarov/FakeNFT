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

    func cellDidSelected(with item: CatalogItem)
    func pullToRefreshDragged()
}

final class CatalogPresenter {
    // MARK: Properties

    weak var view: (any ICatalogView)?
    private let router: any ICatalogRouter
    private let service: any ICatalogItemService
    private var sortStorage: any ISortStorage
    private var catalogItems = [CatalogItem]()

    // MARK: - Lifecycle

    init(
        router: some ICatalogRouter,
        service: some ICatalogItemService,
        sortStorage: some ISortStorage
    ) {
        self.router = router
        self.service = service
        self.sortStorage = sortStorage
    }

    private func loadCatalogItems() {
        service.loadCollectionItems { [weak self] in
            switch $0 {
            case let .success(models):
                guard let self else { return }
                self.view?.dismissLoader()

                self.catalogItems = models
                self.updateItems()
            case let .failure(error):
                self?.view?.dismissLoader()
                assertionFailure(error.localizedDescription)
            }
        }
    }

    private func sortIfNeeded() {
        switch sortStorage.chosenSort {
        case .byNft:
            catalogItems.sort(by: { $0.nfts.count > $1.nfts.count })
        case .byName:
            catalogItems.sort(by: { $0.name < $1.name })
        case .none:
            break
        }
    }

    private func updateItems() {
        sortIfNeeded()
        view?.updateCatalogItems(catalogItems)
    }
}

// MARK: - ICatalogPresenter

extension CatalogPresenter: ICatalogPresenter {
    func pullToRefreshDragged() {
        sortStorage.chosenSort = .none
        loadCatalogItems()
    }

    func viewDidLoad() {
        view?.showLoader()
        loadCatalogItems()
    }

    func sortButtonTapped() {
        view?.showSortingAlert()
    }

    func sortByNameChosen() {
        sortStorage.chosenSort = .byName
        updateItems()
    }

    func sortByQuantityChosen() {
        sortStorage.chosenSort = .byNft
        updateItems()
    }

    func cellDidSelected(with item: CatalogItem) {
        router.openCollectionScreen(with: item)
    }
}
