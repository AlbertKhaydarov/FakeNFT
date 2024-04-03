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
    let model = Profile(name: "11-я кагорта",
                        avatar: "https://mir-s3-cdn-cf.behance.net/project_modules/max_3840/ad380510832315.560ebe4aa17f9.jpg",
                        description: "Привет! связка тестов",
                        website: "https://practicum.yandex.ru/ios-developer/",
                        nfts: [],
                        likes: ["b2f44171-7dcd-46d7-a6d3-e2109aacf520,d6a02bd1-1255-46cd-815b-656174c1d9c0",
    "ca34d35a-4507-47d9-9312-5ea7053994c0,9810d484-c3fc-49e8-bc73-f5e602c36b40"],
                        id: "1e07d999-5de3-47b6-bd74-a643c4d395e4")
    
    // MARK: Properties
    weak var view: (any ProfileViewProtocol)?
    private let router: any ProfileRouterProtocol
    private let service: ProfileServiceProtocol
    
    init(router: some ProfileRouterProtocol, service: ProfileServiceProtocol) {
        self.router = router
        self.service = service
        updateProfile(model: model)
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
                                                      likes: profile.likes)
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
                                                      likes: profile.likes)
//                self.getProfile()
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
