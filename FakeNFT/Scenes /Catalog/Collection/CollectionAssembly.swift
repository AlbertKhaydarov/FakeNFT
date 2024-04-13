//
//  CollectionAssembly.swift
//
//  in: FakeNFT
//  by: MAKOVEY Vladislav
//  on: 22.03.2024
//

import UIKit

final class CollectionAssembly {
    // MARK: - Public

    static func assemble(collectionItem: CatalogItem) -> UIViewController {
        let networkClient = DefaultNetworkClient()
        let nftStorage = NftStorageImpl()

        let profileService: ProfileServiceProtocol = ProfileService(
            networkClient: networkClient,
            storage: NftStorageImpl()
        )
        let orderService: IOrderService = OrderService(networkClient: networkClient)

        let nftService: INftService = NftService(networkClient: networkClient, storage: nftStorage)

        let router = CollectionRouter()
        let presenter = CollectionPresenter(
            chosenItem: collectionItem,
            profileService: profileService,
            orderService: orderService,
            nftService: nftService,
            router: router
        )
        let view = CollectionViewController(
            presenter: presenter,
            layoutProvider: CollectionLayoutProvider()
        )

        presenter.view = view
        router.viewController = view

        return view
    }
}
