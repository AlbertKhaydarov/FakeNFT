//
//  ProfilePresenter.swift
//  FakeNFT
//
//  Created by MAKOVEY Vladislav on 19.03.2024.
//
import Kingfisher
import Foundation

protocol ProfilePresenterProtocol {
    func viewDidLoad()
    func getProfileDetails() -> ProfileViewModel
    func switchToProfileEditView(profile: ProfileViewModel)
    func switchToProfileFavoriteView()
    func switchToProfileMyNFTView()
    func switchToProfileUserWebViewViewController(with url: URL)
    var countTitleButtons: [Int] { get }
}

final class ProfilePresenter {

    // MARK: Properties
    weak var view: (any ProfileViewProtocol)?
    private let router: any ProfileRouterProtocol

    // MARK: - TBD  from presenters
    var countTitleButtons: [Int] = [112, 11, 64]

    init(router: some ProfileRouterProtocol) {
        self.router = router
    }

    // MARK: - Public
    func getProfileDetails() -> ProfileViewModel {
        let profile = ProfileViewModel.getProfile()
        let viewModel = ProfileViewModel(name: profile.name,
                                         userPic: profile.userPic,
                                         description: profile.description,
                                         website: profile.website)
        return viewModel
    }
}

// MARK: - ProfilePresenterProtocol

extension ProfilePresenter: ProfilePresenterProtocol {

    // MARK: - TBD a service implementation
    func viewDidLoad() {
    }

    func switchToProfileEditView(profile: ProfileViewModel) {
        router.switchToProfileEditView(profile: profile)
    }

    func switchToProfileMyNFTView() {
        router.switchToProfileMyNFTView()
    }

    func switchToProfileFavoriteView() {
        router.switchToProfileFavoriteView()
    }

    func switchToProfileUserWebViewViewController(with url: URL) {
        router.switchToProfileUserWebViewViewController(with: url)
    }
}
