//
//  ProfileFavoriteViewController.swift
//  FakeNFT
//
//  Created by Альберт Хайдаров on 26.03.2024.
//

import UIKit

protocol ProfileMyNFTViewProtocol: AnyObject { }

class ProfileMyNFTViewController: UIViewController {

    // MARK: - Properties
    private let presenter: any ProfileMyNFTPresenterProtocol

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = Assets.ypWhite.color
        tableView.register(ProfileMyNFTTableViewCell.self,
                           forCellReuseIdentifier: ProfileMyNFTTableViewCell.profileMyNFTCellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

    private lazy var stubMyNFTLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .bodyBold
        label.textColor = Assets.ypBlack.color
        label.textAlignment = .center
        label.text = .loc.Profile.StubMyNFTLabel.title
        label.isHidden = true
        return label
    }()

    init(presenter: some ProfileMyNFTPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { nil }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = .loc.Profile.MyNFTButton.title
        setupSubview()
        layoutSubviews()
        sortButton()
        isStubHidden()
    }

    // MARK: - Private
    private func isStubHidden() {
        if presenter.myNFT.count == 0 {
            stubMyNFTLabel.isHidden = false
        } else {
            stubMyNFTLabel.isHidden = true
        }
    }

    // MARK: - TBD in the 3rd part

    @objc private func sortButtonTapped() {
        print(#function)
    }

    private func sortButton() {
    let rightButton = UIBarButtonItem(image: Assets.sortImage.image,
                                      style: .plain,
                                      target: self,
                                      action: #selector(sortButtonTapped))
        self.navigationItem.rightBarButtonItem = rightButton
        rightButton.tintColor = Assets.ypBlack.color
    }

    private func setupSubview() {
        view.addSubview(tableView)
        view.addSubview(stubMyNFTLabel)
    }

    private func layoutSubviews() {
        let height = presenter.myNFT.count * 140
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.heightAnchor.constraint(equalToConstant: CGFloat(height)),

            stubMyNFTLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stubMyNFTLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stubMyNFTLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stubMyNFTLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
}

// MARK: - ProfileMyNFTViewProtocol

// MARK: - TBD in the 2nd part
extension ProfileMyNFTViewController: ProfileMyNFTViewProtocol { }

// MARK: - UITableViewDataSource
extension ProfileMyNFTViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ProfileMyNFTTableViewCell.profileMyNFTCellIdentifier,
            for: indexPath) as? ProfileMyNFTTableViewCell
        else {
            return UITableViewCell()
        }
        cell.configureCell(indexPath: indexPath, with: presenter)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ProfileMyNFTViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140.0
    }
}
