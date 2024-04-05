//
//  ProfileFavoritePresenter.swift
//  FakeNFT
//
//  Created by Альберт Хайдаров on 26.03.2024.
//

import Foundation

protocol ProfileMyNFTPresenterProtocol {
    func viewDidLoad()
}

final class ProfileMyNFTPresenter {

    // MARK: Properties

    weak var view: (any ProfileMyNFTViewProtocol)?
    private let router: any ProfileMyNFTRouterProtocol
    private let service: ProfileMyNftServiceProtocol

    init(router: some ProfileMyNFTRouterProtocol, service: ProfileMyNftServiceProtocol) {
        self.router = router
        self.service = service
    }

   private func getMyNFTs() {
        service.loadNfts { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let nfts):
                let myNfts = nfts.map { item in
                    return MyNFTViewModel(name: item.name,
                                          imagePath: item.images[0],
                                          starsRating: item.rating,
                                          author: item.name,
                                          price: item.price,
                                          id: item.id)
                }
                self.view?.updateMyNFTs(myNFTs: myNfts)
            case .failure(let error):
                assertionFailure("Failed to load Profile \(error)")
            }
        }
    }
}

// MARK: - ProfileEditPresenterProtocol

extension ProfileMyNFTPresenter: ProfileMyNFTPresenterProtocol {
    func viewDidLoad() {
        getMyNFTs()
    }
}
