//
//  ProfileEditPresenter.swift
//  FakeNFT
//
//  Created by Альберт Хайдаров on 25.03.2024.
//

import Foundation

protocol ProfileEditPresenterProtocol {
    func viewDidLoad()
    var profile: ProfileViewModel { get }
}

final class ProfileEditPresenter {
    // MARK: Properties
    private let router: any ProfileEditRouterProtocol
    private let service: ProfileServiceProtocol
    var profile: ProfileViewModel
    
    weak var view: (any ProfileEditViewProtocol)?

    init(router: some ProfileEditRouterProtocol, profile: ProfileViewModel, service: ProfileServiceProtocol) {
        self.router = router
        self.profile = profile
        self.service = service
    }
    
    func updateProfile(model: Profile?) {
        service.uploadProfile(model: model) {[weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let profile):
                let profileDetails = ProfileViewModel(name: profile.name,
                                                      userPic: profile.avatar,
                                                      description: profile.description,
                                                      website: profile.website,
                                                      nfts: profile.nfts,
                                                      likes: profile.likes)
//                self.getProfile()
            case .failure(let error):
                assertionFailure("Failed to load Profile \(error)")
            }
        }
    }
}

// MARK: - ProfileEditPresenterProtocol

extension ProfileEditPresenter: ProfileEditPresenterProtocol {
    // MARK: - TBD a service implementation
    func viewDidLoad() {
    }
}
