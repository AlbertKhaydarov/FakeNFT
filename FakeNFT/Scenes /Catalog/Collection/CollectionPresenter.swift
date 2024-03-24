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
        let profileInfo = ProfileInfo.makeProfileInfo()
        let order = Order.makeMockOrder()
        let nft = Nft.makeMockNft()

        let personalizedNfts = chosenItem.nfts.map { nftId in
            PersonalizedNft(
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
        view?.updateNfts(personalizedNfts)
    }

    func authorsLinkTapped(with link: String?) {
        guard let link, let url = URL(string: link) else { return }
        router.openWebView(with: url)
    }
}
