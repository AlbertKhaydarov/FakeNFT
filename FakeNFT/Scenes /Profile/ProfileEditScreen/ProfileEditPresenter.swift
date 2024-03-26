//
//  ProfileEditPresenter.swift
//  FakeNFT
//
//  Created by Альберт Хайдаров on 25.03.2024.
//

import Foundation

protocol ProfileEditPresenterProtocol {
    func viewDidLoad()
    var userNameText: String? { get set }
    var descriptionText: String? { get set }
    var websiteText: String? { get set }
}

final class ProfileEditPresenter {
    // MARK: Properties

    weak var view: (any ProfileEditViewProtocol)?
    private let router: any ProfileEditRouterProtocol

    var userNameText: String? = "Joaquin Phoenix"
    var descriptionText: String? = "Дизайнер из Казани, люблю цифровое искусство и бейглы. В моей коллекции уже 100+ NFT, и еще больше — на моём сайте. Открыт к коллаборациям."
    var websiteText: String? = "Joaquin Phoenix.com"


    // MARK: - Lifecycle

    init(router: some ProfileEditRouterProtocol) {
        self.router = router

    }

    // MARK: - Public

    // MARK: - Private
}

// MARK: - ProfileEditPresenterProtocol

extension ProfileEditPresenter: ProfileEditPresenterProtocol {
    func viewDidLoad() {
    }
    
    
}
