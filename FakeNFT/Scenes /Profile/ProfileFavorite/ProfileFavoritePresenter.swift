//
//  ProfileFavoritePresenter.swift
//  FakeNFT
//
//  Created by Альберт Хайдаров on 26.03.2024.
//

import Foundation

protocol ProfileFavoritePresenterProtocol {
    func viewDidLoad()
    var favoritesNFT: [FavoritesViewModel] { get set }
}

final class ProfileFavoritePresenter {
    // MARK: Properties

    var favoritesNFT: [FavoritesViewModel] = []
    

    weak var view: (any ProfileFavoriteViewProtocol)?
    private let router: any ProfileFavoriteRouterProtocol
    
    // MARK: - Lifecycle

    init(router: some ProfileFavoriteRouterProtocol) {
        self.router = router
//        getMockData()
    }

    // MARK: - Public

    // MARK: - Private
   
    // MARK: - Generate Mock Data
    func getMockData() {
        favoritesNFT.append(FavoritesViewModel.getNFT())
        favoritesNFT.append(FavoritesViewModel.getNFT())
        favoritesNFT.append(FavoritesViewModel.getNFT())
    }
}

// MARK: - ProfileEditPresenterProtocol

extension ProfileFavoritePresenter: ProfileFavoritePresenterProtocol {
    func viewDidLoad() {
    }
    
    
}
