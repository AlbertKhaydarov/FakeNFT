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
    func authorsLinkTapped(with link: String?)
}

final class CollectionPresenter {
    // MARK: Properties

    weak var view: (any ICollectionView)?
    private let chosenItem: CatalogItem
    private let profileService: any IProfileService
    private let orderService: any IOrderService
    private let nftService: any INftService
    private let router: any ICollectionRouter

    // MARK: - Lifecycle

    init(
        chosenItem: CatalogItem,
        profileService: any IProfileService,
        orderService: any IOrderService,
        nftService: any INftService,
        router: some ICollectionRouter
    ) {
        self.chosenItem = chosenItem
        self.profileService = profileService
        self.orderService = orderService
        self.nftService = nftService
        self.router = router
    }
}

// MARK: - ICollectionPresenter

extension CollectionPresenter: ICollectionPresenter {
    func viewDidLoad() {
        // TODO: network call
        let profileInfo = ProfileInfo.makeProfileInfo()
        let order = Order.makeMockOrder()
        let nft = Nft.makeMockNft()

        let collectionViewModel = chosenItem.nfts.map { nftId in
            CollectionViewModel(
                id: nftId,
                name: nft.name,
                price: nft.price,
                website: profileInfo.website,
                imagePath: nft.images[0],
                rating: nft.rating,
                liked: profileInfo.likes.first(where: { $0 == nftId }) != nil,
                inCart: order.nfts.first(where: { $0 == nftId }) != nil
            )
        }

        view?.updateCollectionInfo(chosenItem, profileInfo: profileInfo)
        view?.updateNfts(collectionViewModel)
    }

    func authorsLinkTapped(with link: String?) {
        guard let link, let url = URL(string: link) else { return }
        router.openWebView(with: url)
    }
}
