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
    func getProfile()
    func switchToProfileEditView(profile: ProfileViewModel)
    func switchToProfileFavoriteView()
    func switchToProfileMyNFTView()
    func switchToProfileUserWebViewViewController(with url: URL)
}

final class ProfilePresenter {

    // MARK: Properties
    weak var view: (any ProfileViewProtocol)?
    private let router: any ProfileRouterProtocol
    private let service: ProfileServiceProtocol
//    private var profileServiceObserver: NSObjectProtocol?

    init(router: some ProfileRouterProtocol, service: ProfileServiceProtocol) {
        self.router = router
        self.service = service
    }

    // MARK: - Public
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
                                                      likes: profile.likes,
                                                      id: profile.id)
                self.view?.updateProfileDetails(profileModel: profileDetails)
            case .failure(let error):
                assertionFailure("Failed to load Profile \(error)")
            }
        }
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
                                                      likes: profile.likes,
                                                      id: profile.id)
                self.getProfile()
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
        getProfile()
    }

    func switchToProfileEditView(profile: ProfileViewModel) {
        if let destination = ProfileEditAssembly.assemble(profile: profile) as? ProfileEditViewController {
            router.switchToProfileEditView(to: destination, profile: profile)
            destination.delegate = self
        }
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

extension ProfilePresenter: ObserverProtocol {
    func didCloseViewController(model: Profile) {
        updateProfile(model: model)    }
}
