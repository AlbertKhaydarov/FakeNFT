//
//  ProfileViewController.swift
//  FakeNFT
//
//  Created by MAKOVEY Vladislav on 19.03.2024.
//

import UIKit

protocol IProfileView: AnyObject { }

final class ProfileViewController: UIViewController {
    // MARK: - Properties

    private let presenter: any IProfilePresenter

    // MARK: - Lifecycle

    init(presenter: some IProfilePresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { nil }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

// MARK: - IProfileView

extension ProfileViewController: IProfileView { }
