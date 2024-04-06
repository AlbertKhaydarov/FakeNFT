//
//  ProfileFavoritesPresenter.swift
//  FakeNFT
//
//  Created by Альберт Хайдаров on 27.03.2024.
//

import Foundation

protocol ProfileFavoritesPresenterProtocol {
    func viewDidLoad()
    func updateProfile(favorites: [MyNFTViewModel]?) 
//    var favoritesNFT: [MyNFTViewModel] { get set }
}

final class ProfileFavoritesPresenter {

    // MARK: Properties
//    var favoritesNFT: [MyNFTViewModel] = []
    weak var view: (any ProfileFavoritesViewProtocol)?
    private let router: any ProfileFavoritesRouterProtocol
    private let service: ProfileMyNftServiceProtocol
    
    init(router: some ProfileFavoritesRouterProtocol, service: ProfileMyNftServiceProtocol) {
        self.router = router
        self.service = service

    }

    private func getFavoritesNFTs() {
        service.loadFavoritesNfts { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let nfts):
                let favoriteNfts = nfts.map { item in
                    return MyNFTViewModel(createdAt: item.createdAt,
                                          name: item.name,
                                          images: item.images,
                                          rating: item.rating,
                                          description: item.description,
                                          price: item.price,
                                          author: item.author,
                                          id: item.id,
                                          isLiked: true)
                }
                self.view?.updateFavoritesNFTs(favoriteNFTs: favoriteNfts)
            case .failure(let error):
                assertionFailure("Failed to load Profile \(error)")
            }
        }
    }

        func updateProfile(favorites: [MyNFTViewModel]?) {
            guard let favorites = favorites else {return}
            service.uploadFavoritesNFTs(nfts: favorites) {[weak self] result in
                guard let self = self else {return}
                switch result {
                case .success(let profile):
    
                    let profileDetails = ProfileViewModel(name: profile.name,
                                                          userPic: profile.avatar,
                                                          description: profile.description,
                                                          website: profile.website,
                                                          nfts: profile.nfts,
                                                          likes: profile.likes,
                                                          id: profile.id)
                    getFavoritesNFTs()
//print(profileDetails)
                case .failure(let error):
                    assertionFailure("Failed to load Profile \(error)")
                }
            }
        }
}

// MARK: - ProfileEditPresenterProtocol

extension ProfileFavoritesPresenter: ProfileFavoritesPresenterProtocol {
    func viewDidLoad() {
        getFavoritesNFTs()
    }
}
