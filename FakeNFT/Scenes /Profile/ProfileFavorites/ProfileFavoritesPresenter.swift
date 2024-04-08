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
}

final class ProfileFavoritesPresenter {

    // MARK: Properties
    weak var view: (any ProfileFavoritesViewProtocol)?
    private let router: any ProfileFavoritesRouterProtocol
    private let service: ProfileMyNftServiceProtocol

    init(router: some ProfileFavoritesRouterProtocol, service: ProfileMyNftServiceProtocol) {
        self.router = router
        self.service = service
    }

    private func getFavoritesNFTs() {
        UIBlockingProgressHUD.show()
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
                var favoritesNFTsSortedDefault = favoriteNfts
                favoritesNFTsSortedDefault = favoritesNFTsSortedDefault.sorted { $0.name < $1.name }
                UIBlockingProgressHUD.dismiss()
                self.view?.updateFavoritesNFTs(favoriteNFTs: favoritesNFTsSortedDefault)
            case .failure(let error):
                assertionFailure("Failed to load Profile \(error)")
                UIBlockingProgressHUD.dismiss()
            }
        }
    }

    func updateProfile(favorites: [MyNFTViewModel]?) {
        guard let favorites = favorites else {return}
        service.uploadFavoritesNFTs(nfts: favorites) {[weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let profile):
                getFavoritesNFTs()
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
