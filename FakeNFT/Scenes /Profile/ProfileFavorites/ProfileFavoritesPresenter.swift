//
//  ProfileFavoritesPresenter.swift
//  FakeNFT
//
//  Created by Альберт Хайдаров on 27.03.2024.
//

import Foundation

protocol ProfileFavoritesPresenterProtocol {
    func viewDidLoad()
    var favoritesNFT: [MyNFTViewModel] { get set }
}

final class ProfileFavoritesPresenter {
    
    // MARK: Properties
    var favoritesNFT: [MyNFTViewModel] = []
    
    weak var view: (any ProfileFavoritesViewProtocol)?
    private let router: any ProfileFavoritesRouterProtocol
    
    init(router: some ProfileFavoritesRouterProtocol) {
        self.router = router
        getMockData()
    }
    
    // MARK: - Generate Mock Data
    func getMockData() {
        favoritesNFT.append(MyNFTViewModel.getNFT())
        favoritesNFT.append(MyNFTViewModel.getNFT())
        favoritesNFT.append(MyNFTViewModel.getNFT())
    }
}

// MARK: - ProfileEditPresenterProtocol

extension ProfileFavoritesPresenter: ProfileFavoritesPresenterProtocol {
    func viewDidLoad() {
        //TODO: -
    }
    
    
}
