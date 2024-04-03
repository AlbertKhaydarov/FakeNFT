//
//  ProfileFavoritesPresenter.swift
//  FakeNFT
//
//  Created by Альберт Хайдаров on 27.03.2024.
//

import Foundation

protocol ProfileFavoritesPresenterProtocol {
    func viewDidLoad()
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
                    return MyNFTViewModel(name: item.name,
                                          imagePath: item.images[0],
                                          starsRating: item.rating,
                                          author: item.name,
                                          price: item.price,
                                          isFavorite: false)
                }
                self.view?.updateFavoritesNFTs(favoriteNFTs: favoriteNfts)
            case .failure(let error):
                assertionFailure("Failed to load Profile \(error)")
            }
        }
    }

//   b
}

// MARK: - ProfileEditPresenterProtocol

extension ProfileFavoritesPresenter: ProfileFavoritesPresenterProtocol {
    func viewDidLoad() {
        getFavoritesNFTs()
    }
}
