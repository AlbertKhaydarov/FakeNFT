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
    func getProfile()
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
    private let service: ProfileServiceProtocol
    private var profile: ProfileViewModel?

    // MARK: - TBD  from presenters
    var countTitleButtons: [Int] = []

    init(router: some ProfileRouterProtocol, service: ProfileServiceProtocol) {
        self.router = router
        self.service = service
        getProfile()
    }

    // MARK: - Public
    func getProfileDetails() -> ProfileViewModel {
        guard let profile = self.profile else {
            assertionFailure("Failed to get Profile")
            return ProfileViewModel(name: "",
                                    userPic: "",
                                    description: "",
                                    website: "",
                                    nfts: [],
                                    likes: [])
        }
        
        return profile
    }

    func getProfile() {
        service.loadProfile { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let profile):
                let profileDetails = ProfileViewModel(name: profile.name,
                                                userPic: profile.avatar,
                                                description: profile.description,
                                                website: profile.website,
                                                      nfts: profile.nfts,
                                                      likes: profile.likes)
                self.view?.updateProfileDetails(profileModel: profileDetails)
                
                self.profile = profileDetails
                countTitleButtons.insert(profileDetails.nfts.count, at: 0)
                countTitleButtons.insert(profileDetails.likes.count, at: 0)
            case .failure(let error):
                assertionFailure("Failed to load Profile \(error)")
            }
        }
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
