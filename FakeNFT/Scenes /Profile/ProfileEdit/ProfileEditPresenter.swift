//
//  ProfileEditPresenter.swift
//  FakeNFT
//
//  Created by Альберт Хайдаров on 25.03.2024.
//

import Foundation

protocol ProfileEditPresenterProtocol {
    func viewDidLoad()
    func getProfileViewModel() -> ProfileViewModel
}

final class ProfileEditPresenter {
    // MARK: Properties
    private let router: any ProfileEditRouterProtocol
    private let service: ProfileBaseServiceProtocol
    private var profile: ProfileViewModel

    weak var view: (any ProfileEditViewProtocol)?

    init(router: some ProfileEditRouterProtocol, profile: ProfileViewModel, service: ProfileBaseServiceProtocol) {
        self.router = router
        self.profile = profile
        self.service = service
    }

    func getProfileViewModel() -> ProfileViewModel {
        return ProfileViewModel(name: profile.name,
                                userPic: profile.userPic,
                                description: profile.description,
                                website: profile.website,
                                nfts: profile.nfts,
                                likes: profile.likes,
                                id: profile.id)
    }
}

// MARK: - ProfileEditPresenterProtocol

extension ProfileEditPresenter: ProfileEditPresenterProtocol {

    // MARK: - TBD a service implementation
    func viewDidLoad() {
    }
}
