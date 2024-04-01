//
//  ProfileViewController.swift
//  FakeNFT
//
//  Created by MAKOVEY Vladislav on 19.03.2024.
//

import UIKit

protocol ProfileViewProtocol: AnyObject {}

final class ProfileViewController: UIViewController {

    // MARK: - Properties
    private let presenter: any ProfilePresenterProtocol

    private lazy var userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var userNamelabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .headline3
        label.textColor = Assets.ypBlack.color
        label.textAlignment = .left
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .caption2
        label.textColor = Assets.ypBlack.color
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()

    private lazy var websiteLinkLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .caption1
        label.textColor = Assets.ypBlueUniversal.color
        label.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(websiteLinkLabelTapped))
        label.addGestureRecognizer(tapGesture)
        return label
    }()

    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.addArrangedSubview(userProfileImageView)
        stackView.addArrangedSubview(userNamelabel)
        return stackView
    }()

    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.addArrangedSubview(horizontalStackView)
        stackView.addArrangedSubview(descriptionLabel)
        return stackView
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = Assets.ypWhite.color
        tableView.register(ProfileViewTableViewCell.self,
                           forCellReuseIdentifier: ProfileViewTableViewCell.profileViewCellIdentifier)
        tableView.isScrollEnabled = false
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

    lazy var activityIndicator: UIActivityIndicatorView = {
        activityIndicator =  UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()

    init(presenter: some ProfilePresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { nil }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = nil
        presenter.viewDidLoad()
        setupSubview()
        layoutSubviews()
        addEditButton()
        updateProfileDetails()
        navigationController?.navigationBar.prefersLargeTitles = false
        activityIndicator.startAnimating()
        updateUserPic()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        userProfileImageView.layer.cornerRadius = userProfileImageView.bounds.size.width / 2
        userProfileImageView.layer.masksToBounds = true
    }

    // MARK: - Private
    private func addEditButton() {
        let rightButton = UIBarButtonItem(image: Assets.editProfileImage.image,
                                          style: .plain,
                                          target: self,
                                          action: #selector(editButtontapped))
        self.navigationItem.rightBarButtonItem = rightButton
        rightButton.tintColor = Assets.ypBlack.color
    }

    @objc private func editButtontapped() {
        presenter.switchToProfileEditView(profile: presenter.getProfileDetails())
    }

    @objc private func websiteLinkLabelTapped() {
        guard let url = URL(string: ProfileViewModel.getProfile().website) else { return }
        presenter.switchToProfileUserWebViewViewController(with: url)
    }

    private func setupSubview() {
        view.addSubview(verticalStackView)
        view.addSubview(websiteLinkLabel)
        view.addSubview(tableView)
        userProfileImageView.addSubview(activityIndicator)
    }

    private func layoutSubviews() {
        NSLayoutConstraint.activate([
            verticalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            verticalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            verticalStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),

            horizontalStackView.leadingAnchor.constraint(equalTo: verticalStackView.leadingAnchor),
            horizontalStackView.trailingAnchor.constraint(equalTo: verticalStackView.trailingAnchor),
            horizontalStackView.topAnchor.constraint(equalTo: verticalStackView.topAnchor),

            userProfileImageView.widthAnchor.constraint(equalToConstant: 70),
            userProfileImageView.heightAnchor.constraint(equalToConstant: 70),
            userProfileImageView.topAnchor.constraint(equalTo: horizontalStackView.topAnchor),
            userProfileImageView.leadingAnchor.constraint(equalTo: horizontalStackView.leadingAnchor),

            activityIndicator.centerYAnchor.constraint(equalTo: userProfileImageView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: userProfileImageView.centerXAnchor),

            userNamelabel.centerYAnchor.constraint(equalTo: horizontalStackView.centerYAnchor),
            userNamelabel.trailingAnchor.constraint(equalTo: horizontalStackView.trailingAnchor),

            descriptionLabel.leadingAnchor.constraint(equalTo: verticalStackView.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: verticalStackView.trailingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: userProfileImageView.bottomAnchor, constant: 20),

            websiteLinkLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            websiteLinkLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            websiteLinkLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 12),

            tableView.topAnchor.constraint(equalTo: websiteLinkLabel.bottomAnchor, constant: 40),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -221)
        ])
    }

    private func updateProfileDetails() {
        let profileModel = presenter.getProfileDetails()
        userNamelabel.text = profileModel.name
        descriptionLabel.text = profileModel.description
        websiteLinkLabel.text = profileModel.website
    }

    private func updateUserPic() {
        userProfileImageView.kf.indicatorType = .activity
        let profileImageString = presenter.getProfileDetails().userPic
        guard
            let url = URL(string: profileImageString)
        else {
            print("Failed to create full URL")
            return
        }
        userProfileImageView.kf.setImage(with: url)
    }
}

// MARK: - ProfileViewProtocol

extension ProfileViewController: ProfileViewProtocol { }

// MARK: - UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ProfileViewTableViewCell.profileViewCellIdentifier,
            for: indexPath) as? ProfileViewTableViewCell
        else {
            return UITableViewCell()
        }
        cell.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        cell.configureCell(indexPath: indexPath, with: presenter)
        return cell
    }
}
// MARK: - UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            presenter.switchToProfileMyNFTView()
        } else if indexPath.row == 1 {
            presenter.switchToProfileFavoriteView()
        } else if indexPath.row == 2 {
            guard let url = URL(string: ProfileViewModel.getProfile().website) else { return }
            presenter.switchToProfileUserWebViewViewController(with: url)
        }
    }
}
