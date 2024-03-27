//
//  ProfileEditPresenter.swift
//  FakeNFT
//
//  Created by Альберт Хайдаров on 25.03.2024.
//

import UIKit

protocol ProfileEditPresenterProtocol {
    func viewDidLoad()
    var profile: ProfileViewModel { get }
    func updateUserPicImage()
}

final class ProfileEditPresenter {
    // MARK: Properties
    
    weak var view: (any ProfileEditViewProtocol)?
    private let router: any ProfileEditRouterProtocol
    var profile: ProfileViewModel
    
    init(router: some ProfileEditRouterProtocol, profile: ProfileViewModel) {
        self.router = router
        self.profile = profile
    }
    
    func updateUserPicImage() {
        let profileImageString = profile.userPic
        
        guard
            let url = URL(string: profileImageString)
        else {
            print("Failed to create full URL")
            return
        }
        
        let nftImageView = UIImageView()
        nftImageView.kf.setImage(with: url) { result in
            switch result {
            case .success(let value):
                self.view?.updateUserPic(with: value.image)
            case .failure(let error):
                print("Error loading image: \(error)")
            }
        }
    }
}

// MARK: - ProfileEditPresenterProtocol

extension ProfileEditPresenter: ProfileEditPresenterProtocol {
    //TODO: - a service implementation
    func viewDidLoad() {
    }
}
