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
}

final class ProfileMyNFTPresenter {

    // MARK: Properties

    weak var view: (any ProfileMyNFTViewProtocol)?
    private let router: any ProfileMyNFTRouterProtocol
    private let service: ProfileMyNftServiceProtocol
//    private var profileFavoriteNfts: [ProfileMyNFT]?
    private var profileFavoriteNfts: [MyNFTViewModel]?

    init(router: some ProfileMyNFTRouterProtocol, service: ProfileMyNftServiceProtocol) {
        self.router = router
        self.service = service
    }

    func setFavorite(with nft: MyNFTViewModel, isFavorite: Bool) {
//        let existingFavoriteNfts = profileFavoriteNfts?.map({ item in
//            return MyNFTViewModel(createdAt: item.createdAt,
//                                  name: item.name,
//                                  images: item.images,
//                                  rating: item.rating,
//                                  description: item.description,
//                                  price: item.price,
//                                  author: item.author,
//                                  id: item.id,
//                                  isLiked: isFavorite)
//        })
//        guard var existingFavoriteNfts = existingFavoriteNfts else {return}
      
        if isFavorite == true {
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
      
//                let profileDetails = ProfileViewModel(name: profile.name,
//                                                      userPic: profile.avatar,
//                                                      description: profile.description,
//                                                      website: profile.website,
//                                                      nfts: profile.nfts,
//                                                      likes: profile.likes,
//                                                      id: profile.id)
                self.getMyNFTs()
            case .failure(let error):
                assertionFailure("Failed to load Profile \(error)")
            }
        }
    }

    private func getFavoriteNft() {
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
                    if let favoriteNftIndex = self.profileFavoriteNfts?.firstIndex(where: { $0.id == nft.id }) {
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
              var myNFTsSortedDefault = myNfts
                myNFTsSortedDefault = myNFTsSortedDefault.sorted { $0.name < $1.name }
                self.view?.updateMyNFTs(myNFTs: myNFTsSortedDefault)
            case .failure(let error):
                assertionFailure("Failed to load Profile \(error)")
            }
        }
    }
}

// MARK: - ProfileEditPresenterProtocol

extension ProfileMyNFTPresenter: ProfileMyNFTPresenterProtocol {
    func viewDidLoad() {
        getFavoriteNft()
    }
}
