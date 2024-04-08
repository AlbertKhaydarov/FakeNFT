//
//  ProfileFavoritePresenter.swift
//  FakeNFT
//
//  Created by Альберт Хайдаров on 26.03.2024.
//

import Foundation

protocol ProfileMyNFTPresenterProtocol {
    func viewDidLoad()
    func setFavorite(with nft: MyNFTViewModel, isFavorite: Bool)
    func sortButtonTapped()
    func sortByPrice()
    func sortByRatingAction()
    func sortByNameAction()
}

final class ProfileMyNFTPresenter {

    // MARK: Properties

    weak var view: (any ProfileMyNFTViewProtocol)?
    private let router: any ProfileMyNFTRouterProtocol
    private let service: any ProfileMyNftServiceProtocol
    private var profileFavoriteNfts: [MyNFTViewModel]?
    private var profileStorage: any ProfileUserDefaultsStorageProtocol
    private var profileMyNfts: [MyNFTViewModel]?

    init(router: some ProfileMyNFTRouterProtocol,
         service: some ProfileMyNftServiceProtocol,
         profileStorage: some ProfileUserDefaultsStorageProtocol) {
        self.router = router
        self.service = service
        self.profileStorage = profileStorage
    }

    private func getSortedItems() {
        sortedNFTs()
        guard let profileMyNfts else {return}
        view?.updateMyNFTs(myNFTs: profileMyNfts)
    }
    
    private func sortedNFTs() {
        switch profileStorage.chosenTypeSort {
        case .byPrice:
            profileMyNfts?.sort(by: { $0.price > $1.price })
        case .byRating:
            profileMyNfts?.sort(by: { $0.rating > $1.rating })
        case .byName:
            profileMyNfts?.sort(by: { $0.name < $1.name })
        case .none:
            break
        }
    }

    func setFavorite(with nft: MyNFTViewModel, isFavorite: Bool) {
        UIBlockingProgressHUD.show()
        if isFavorite {
            profileFavoriteNfts?.append(nft)
        } else {
            if let favoriteNftIndex = profileFavoriteNfts?.firstIndex(where: { $0.id == nft.id }) {
                profileFavoriteNfts?.remove(at: favoriteNftIndex)
            }
        }
        updateProfile(nfts: profileFavoriteNfts)
    }

    private func updateProfile(nfts: [MyNFTViewModel]?) {
        guard let nfts = nfts else {return}
        service.uploadFavoritesNFTs(nfts: nfts) {[weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let profile):
                self.getMyNFTs()
            case .failure(let error):
                assertionFailure("Failed to load Profile \(error)")
            }
        }
    }

    private func getFavoriteNft() {
        UIBlockingProgressHUD.show()
        service.loadFavoritesNfts { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let nfts):
                self.profileFavoriteNfts = nfts.map({ item in
                    return MyNFTViewModel(createdAt: item.createdAt,
                                          name: item.name,
                                          images: item.images,
                                          rating: item.rating,
                                          description: item.description,
                                          price: item.price,
                                          author: item.author,
                                          id: item.id,
                                          isLiked: true)
                })
                getMyNFTs()
            case .failure(let error):
                assertionFailure("Failed to load Profile \(error)")
            }
        }
    }

    private func getMyNFTs() {
        service.loadNfts { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let nfts):
                let myNfts = nfts.map { nft -> MyNFTViewModel in
                    if (self.profileFavoriteNfts?.firstIndex(where: { $0.id == nft.id })) != nil {
                        return MyNFTViewModel(createdAt: nft.createdAt,
                                              name: nft.name,
                                              images: nft.images,
                                              rating: nft.rating,
                                              description: nft.description,
                                              price: nft.price,
                                              author: nft.author,
                                              id: nft.id,
                                              isLiked: true)
                    } else {
                        return MyNFTViewModel(createdAt: nft.createdAt,
                                              name: nft.name,
                                              images: nft.images,
                                              rating: nft.rating,
                                              description: nft.description,
                                              price: nft.price,
                                              author: nft.author,
                                              id: nft.id,
                                              isLiked: false)
                    }
                }
                profileMyNfts = myNfts
                var myNFTsSortedDefault = myNfts
                myNFTsSortedDefault = myNFTsSortedDefault.sorted { $0.name < $1.name }
                UIBlockingProgressHUD.dismiss()
                self.view?.updateMyNFTs(myNFTs: myNFTsSortedDefault)
            case .failure(let error):
                assertionFailure("Failed to load Profile \(error)")
                UIBlockingProgressHUD.dismiss()
            }
        }
    }
}

// MARK: - ProfileEditPresenterProtocol

extension ProfileMyNFTPresenter: ProfileMyNFTPresenterProtocol {
    func viewDidLoad() {
        getFavoriteNft()
    }
    
    func sortButtonTapped() {
        view?.showSortingAlert()
    }
    
    func sortByPrice() {
        profileStorage.chosenTypeSort = .byPrice
        getSortedItems()
    }
    
    func sortByRatingAction() {
        profileStorage.chosenTypeSort = .byRating
        getSortedItems()
    }
    
    func sortByNameAction() {
        profileStorage.chosenTypeSort = .byName
        getSortedItems()
    }
    
    func refreshAction() {
        profileStorage.chosenTypeSort = .none
        getMyNFTs()
    }
}
