//
//  ProfileFavoritePresenter.swift
//  FakeNFT
//
//  Created by Альберт Хайдаров on 26.03.2024.
//

import Foundation

protocol ProfileMyNFTPresenterProtocol {
    func viewDidLoad()
    var myNFT: [MyNFTViewModel] { get set }
}

final class ProfileMyNFTPresenter {
    // MARK: Properties
    
    var myNFT: [MyNFTViewModel] = []
    
    
    weak var view: (any ProfileMyNFTViewProtocol)?
    private let router: any ProfileMyNFTRouterProtocol
    
    init(router: some ProfileMyNFTRouterProtocol) {
        self.router = router
        getMockData()
    }
    
    // MARK: - Generate Mock Data
    func getMockData() {
        myNFT.append(MyNFTViewModel.getNFT())
        myNFT.append(MyNFTViewModel.getNFT())
        myNFT.append(MyNFTViewModel.getNFT())
    }
}

// MARK: - ProfileEditPresenterProtocol

extension ProfileMyNFTPresenter: ProfileMyNFTPresenterProtocol {
    func viewDidLoad() {
    }
    
    
}
