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
}

final class CatalogPresenter {
    // MARK: Properties

    weak var view: (any ICatalogView)?
    private let router: any ICatalogRouter
    private let service: any ICatalogItemService
    private var catalogItems = [CatalogItem]()

    // MARK: - Lifecycle

    init(
        router: some ICatalogRouter,
        service: some ICatalogItemService
    ) {
        self.router = router
        self.service = service
    }
}

// MARK: - ICatalogPresenter

extension CatalogPresenter: ICatalogPresenter {
    func viewDidLoad() {
        view?.showLoader()

        service.loadCollectionItems { [weak self] in
            switch $0 {
            case let .success(models):
                guard let self else { return }
                self.view?.dismissLoader()

                self.catalogItems = models
                self.view?.updateCatalogItems(self.catalogItems)
            case let .failure(error):
                self?.view?.dismissLoader()
                assertionFailure(error.localizedDescription) // TODO: handle error
            }
        }
    }

    func sortButtonTapped() {
        view?.showSortingAlert()
    }

    func sortByNameChosen() {
        catalogItems.sort(by: { $0.name < $1.name })
        view?.updateCatalogItems(catalogItems)
    }

    func sortByQuantityChosen() {
        catalogItems.sort(by: { $0.nfts.count > $1.nfts.count })
        view?.updateCatalogItems(catalogItems)
    }

    func cellDidSelected(with item: CatalogItem) {
        router.openCollectionScreen(with: item)
    }
}
