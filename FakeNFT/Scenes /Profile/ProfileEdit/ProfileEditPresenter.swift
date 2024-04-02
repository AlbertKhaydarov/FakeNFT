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

    weak var view: (any ProfileEditViewProtocol)?
    private let router: any ProfileEditRouterProtocol
    var profile: ProfileViewModel

    init(router: some ProfileEditRouterProtocol, profile: ProfileViewModel) {
        self.router = router
        self.profile = profile
    }
}

// MARK: - ProfileEditPresenterProtocol

extension ProfileEditPresenter: ProfileEditPresenterProtocol {
    // MARK: - TBD a service implementation
    func viewDidLoad() {
    }
}
