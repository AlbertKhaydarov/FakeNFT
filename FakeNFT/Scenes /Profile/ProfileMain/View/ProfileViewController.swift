//
//  ProfileViewController.swift
//  FakeNFT
//
//  Created by MAKOVEY Vladislav on 19.03.2024.
//

import UIKit

protocol ProfileViewProtocol: AnyObject {
    func updateProfileDetails(profileModel: ProfileViewModel)
}

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
        tableView.register(ProfileViewTableViewCell.self)
        tableView.isScrollEnabled = false
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

    private var profileViewModel: ProfileViewModel?

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
        setupView()
        setupSubview()
        layoutSubviews()
        addEditButton()
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
        guard let profileViewModel = profileViewModel else { return }
        presenter.switchToProfileEditView(profile: profileViewModel)
    }

    @objc private func websiteLinkLabelTapped() {
        guard let profileViewModel = profileViewModel,
        let url = URL(string: profileViewModel.website)
        else { return }
        presenter.switchToProfileUserWebViewViewController(with: url)
    }

    func updateProfileDetails(profileModel: ProfileViewModel) {
        userNamelabel.text = profileModel.name
        descriptionLabel.text = profileModel.description
        websiteLinkLabel.text = profileModel.website
        updateUserPic(url: profileModel.userPic)
        self.profileViewModel = profileModel
        tableView.reloadData()
        activityIndicator.stopAnimating()
    }

    func getUpdate() {
        presenter.getProfile()
    }

    private func updateUserPic(url: String) {
        userProfileImageView.kf.indicatorType = .activity
        guard let url = URL(string: url) else {
            return
        }
        userProfileImageView.kf.setImage(with: url)
    }

    private func setupView() {
        self.title = nil
        presenter.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
        activityIndicator.startAnimating()
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

            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),

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
}

// MARK: - ProfileViewProtocol

extension ProfileViewController: ProfileViewProtocol { }

// MARK: - UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ProfileViewTableViewCell = tableView.dequeueReusableCell()
        cell.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        if let profileViewModel = profileViewModel {
            cell.configureCell(indexPath: indexPath, with: profileViewModel)
        }
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
            guard let profileViewModel = profileViewModel,
            let url = URL(string: profileViewModel.website)
            else { return }
            presenter.switchToProfileUserWebViewViewController(with: url)
        }
    }
}
