//
//  ProfilePresenter.swift
//  FakeNFT
//
//  Created by MAKOVEY Vladislav on 19.03.2024.
//
import Kingfisher
import UIKit

protocol ProfilePresenterProtocol {
    func viewDidLoad()
    func getProfileDetails() -> ProfileViewModel
    func updateUserPicImage()
//    func switchToProfileEditView(from: UIViewController)
    func switchToProfileEditView(from: UIViewController, profile: ProfileViewModel)
    func switchToProfileFavoriteView()
    func switchToProfileMyNFTView()
    func switchToProfileUserWebViewViewController(with url: URL)
    var countTitleButtons: [Int] { get }
}

final class ProfilePresenter {
    // MARK: Properties
    
    weak var view: (any ProfileViewProtocol)?
    private let router: any ProfileRouterProtocol
    
    //TODO: - from presenters
    var countTitleButtons: [Int] = [112, 11, 64]
    // MARK: - Lifecycle
    
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
    
    func updateUserPicImage() {
        let profile = ProfileViewModel.getProfile()
        let profileImageString = profile.userPic
        
        guard
            let url = URL(string: profileImageString)
        else {
            print("Failed to create full URL")
            return
        }
        
        let nftImageView = UIImageView()
        
        //TODO: - remove DispatchQueue.main.asyncAfter(deadline: .now() + 2) after a service implementation
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            nftImageView.kf.setImage(with: url) { result in
                self.view?.activityIndicator.stopAnimating()
                switch result {
                case .success(let value):
                    self.view?.updateUserPic(with: value.image)
                case .failure(let error):
                    print("Error loading image: \(error)")
                }
            }
        }
    }
}

// MARK: - ProfilePresenterProtocol

extension ProfilePresenter: ProfilePresenterProtocol {
    //TODO: - a service implementation
    func viewDidLoad() {
    }
    
    func switchToProfileEditView(from: UIViewController, profile: ProfileViewModel) {
        router.switchToProfileEditView(from: from, profile: profile)
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
