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

    func didSelectNft(id: String)
}

final class CollectionPresenter {
    private enum Constant {
        static let website = "https://practicum.yandex.ru/ios-developer"
    }
    // MARK: Properties

    weak var view: (any ICollectionView & ErrorView)?
    private let chosenItem: CatalogItem
    private let profileService: any ProfileServiceProtocol
    private let orderService: any IOrderService
    private let nftService: any INftService
    private let router: any ICollectionRouter
    private let dispatchGroup = DispatchGroup()

    private var profile: Profile?
    private var order: Order?
    private var nfts: [Nft]?

    // MARK: - Lifecycle

    init(
        chosenItem: CatalogItem,
        profileService: any ProfileServiceProtocol,
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
        view?.showLoader()

        loadProfile()
        loadOrder()
        loadNft()

        dispatchGroup.notify(qos: .userInteractive, queue: .main) {
            self.assembleViewModel()
        }
    }

    private func loadProfile() {
        dispatchGroup.enter()
        profileService.loadProfile { [weak self] result in
            switch result {
            case let .success(model):
                self?.profile = model
            case .failure:
                self?.showError()
            }
            self?.dispatchGroup.leave()
        }
    }

    private func loadOrder() {
        dispatchGroup.enter()
        orderService.loadOrder { [weak self] order in
            guard let order else {
                self?.dispatchGroup.leave()
                self?.showError()
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
                guard let nft else {
                    self?.dispatchGroup.leave()
                    self?.showError()
                    return
                }

                self?.nfts?.append(nft)
                self?.dispatchGroup.leave()
            }
        }
    }

    private func assembleViewModel() {
        guard let nfts, let profile, let order else { return }

        let collectionViewModel = nfts.sorted(by: { $0.name < $1.name }).map { nft in
            CollectionViewModel(
                id: nft.id,
                name: nft.name,
                price: nft.price,
                website: Constant.website,
                imagePath: nft.images[0],
                rating: nft.rating,
                liked: profile.likes.first(where: { $0 == nft.id }) != nil,
                inCart: order.nfts.first(where: { $0 == nft.id }) != nil
            )
        }

        view?.updateCollectionInfo(chosenItem, profile: profile)
        view?.updateNfts(collectionViewModel)
        view?.dismissLoader()
    }

    private func showError() {
        self.view?.dismissLoader()
        self.view?.showError(
            .init(
                message: .loc.Common.errorTitle,
                actionText: .loc.Common.errorRepeatTitle
            ) {
                self.loadAllInfo()
            }
        )
    }
}

// MARK: - ICollectionPresenter

extension CollectionPresenter: ICollectionPresenter {
    func viewDidLoad() {
        loadAllInfo()
    }

    func authorsLinkTapped(with link: String?) {
        guard let link, let url = URL(string: link) else { return }
        router.openWebView(with: url)
    }

    func favoriteButtonTapped(id: String, state: Bool) {
        guard let profile else { return }

        let newProfile: Profile
        if state {
            var newLikes = profile.likes
            newLikes.append(id)

            newProfile = .init(
                name: profile.name,
                avatar: profile.avatar,
                description: profile.description,
                website: profile.website,
                nfts: profile.nfts,
                likes: newLikes,
                id: profile.id
            )
        } else {
            newProfile = .init(
                name: profile.name,
                avatar: profile.avatar,
                description: profile.description,
                website: profile.website,
                nfts: profile.nfts,
                likes: profile.likes.filter { $0 != id },
                id: profile.id
            )
        }

        profileService.uploadProfile(model: newProfile) { [weak self] result in
            switch result {
            case let .success(profile):
                self?.profile = profile
            case .failure:
                self?.showError()
                return
            }
        }
    }

    func cartButtonTapped(id: String, state: Bool) {
        guard let order else { return }

        var ids = order.nfts

        if state {
            ids.append(id)
        } else {
            ids = ids.filter { $0 != id }
        }

        orderService.updateOrder(nftIds: ids) { [weak self] order in
            guard let order else {
                self?.showError()
                return
            }
            self?.order = order
        }
    }

    func didSelectNft(id: String) {
        router.openNftDetal(with: id)
    }
}
