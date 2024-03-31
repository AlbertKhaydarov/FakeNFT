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

    func favoriteButtonTapped(id: String, state: Bool)
    func cartButtonTapped(id: String, state: Bool)
}

final class CollectionPresenter {
    private enum Constant {
        static let website = "https://practicum.yandex.ru/ios-developer"
    }
    // MARK: Properties

    weak var view: (any ICollectionView)?
    private let chosenItem: CatalogItem
    private let profileService: any IProfileService
    private let orderService: any IOrderService
    private let nftService: any INftService
    private let router: any ICollectionRouter
    private let dispatchGroup = DispatchGroup()

    private var profileInfo: ProfileInfo?
    private var order: Order?
    private var nfts: [Nft]?

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

    private func loadAllInfo() {
        loadProfile()
        loadOrder()
        loadNft()

        dispatchGroup.notify(qos: .userInteractive, queue: .main) {
            self.assembleViewModel()
        }
    }

    private func loadProfile() {
        dispatchGroup.enter()
        profileService.loadProfile { [weak self] profileInfo in
            guard let profileInfo else {
                assertionFailure("Profile can't be loaded") // TODO: handle error
                return
            }

            self?.profileInfo = profileInfo
            self?.dispatchGroup.leave()
        }
    }

    private func loadOrder() {
        dispatchGroup.enter()
        orderService.loadOrder { [weak self] order in
            guard let order else {
                assertionFailure("Order can't be loaded") // TODO: handle error
                return
            }
            self?.order = order
            self?.dispatchGroup.leave()
        }
    }

    private func loadNft() {
        nfts = []
        chosenItem.nfts.forEach {
            dispatchGroup.enter()
            nftService.loadNft(id: $0) { [weak self] nft in
                guard let nft, let self else {
                    assertionFailure("Nft can't be loaded") // TODO: handle error
                    return
                }

                self.nfts?.append(nft)
                self.dispatchGroup.leave()
            }
        }
    }

    private func assembleViewModel() {
        guard let nfts, let profileInfo, let order else { return }

        let collectionViewModel = nfts.map { nft in
            CollectionViewModel(
                id: nft.id,
                name: nft.name,
                price: nft.price,
                website: Constant.website,
                imagePath: nft.images[0],
                rating: nft.rating,
                liked: profileInfo.likes.first(where: { $0 == nft.id }) != nil,
                inCart: order.nfts.first(where: { $0 == nft.id }) != nil
            )
        }

        view?.updateCollectionInfo(chosenItem, profileInfo: profileInfo)
        view?.updateNfts(collectionViewModel)
        view?.dismissLoader()
    }
}

// MARK: - ICollectionPresenter

extension CollectionPresenter: ICollectionPresenter {
    func viewDidLoad() {
        view?.showLoader()
        loadAllInfo()
    }

    func authorsLinkTapped(with link: String?) {
        guard let link, let url = URL(string: link) else { return }
        router.openWebView(with: url)
    }

    func favoriteButtonTapped(id: String, state: Bool) {
        profileService.saveProfile(
            profileInfo: profileInfo,
            likedId: id
        ) { [weak self] profileInfo in

            guard let profileInfo else {
                assertionFailure("Profile can't be loaded") // TODO: handle error
                return
            }

            self?.profileInfo = profileInfo
        }
    }

    func cartButtonTapped(id: String, state: Bool) {
        orderService.saveOrder(nftId: id) { [weak self] order in
            guard let order else {
                assertionFailure("Order can't be loaded") // TODO: handle error
                return
            }
            self?.order = order
        }
    }
}
