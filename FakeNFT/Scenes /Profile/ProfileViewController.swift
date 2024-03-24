//
//  ProfileViewController.swift
//  FakeNFT
//
//  Created by MAKOVEY Vladislav on 19.03.2024.
//

import UIKit

protocol ProfileViewProtocol: AnyObject { }

final class ProfileViewController: UIViewController {
    
    // MARK: - Properties
    private let presenter: any ProfilePresenterProtocol
    
    private lazy var userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "userPic")
        return imageView
    }()
    
    private lazy var userNamelabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .headline3
        label.textColor = Assets.ypBlack.color
        label.textAlignment = .left
        label.text = "Joaquin Phoenix"
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .caption2
        label.textColor = Assets.ypBlack.color
        label.numberOfLines = 0
        label.textAlignment = .left
        label.text = "Дизайнер из Казани, люблю цифровое искусство и бейглы. В моей коллекции уже 100+ NFT, и еще больше — на моём сайте. Открыт к коллаборациям."
        return label
    }()
    
    private lazy var websiteLinkLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .caption1
        label.textColor = Assets.ypBlueUniversal.color
        label.text = "Joaquin Phoenix.com"
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
        tableView.register(ProfileViewTableViewCell.self, forCellReuseIdentifier: "buttomCellReuseIdentifier")
        tableView.isScrollEnabled = false
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    // MARK: - Lifecycle
    
    init(presenter: some ProfilePresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { nil }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = nil
        presenter.viewDidLoad()
        setupSubview()
        layoutSubviews()
    }
    
    private func setupSubview() {
        view.addSubview(verticalStackView)
        view.addSubview(websiteLinkLabel)
        view.addSubview(tableView)
        
        userProfileImageView.layer.cornerRadius = userProfileImageView.bounds.size.width / 2
        userProfileImageView.layer.masksToBounds = true
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
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -221),
        ])
    }
}

// MARK: - ProfileViewProtocol

extension ProfileViewController: ProfileViewProtocol { }

//MARK: - UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "buttomCellReuseIdentifier", for: indexPath) as? ProfileViewTableViewCell else {return UITableViewCell()}
        cell.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        cell.configureCell(indexPath: indexPath, with: presenter)
        return cell
    }
}
//MARK: - UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54.0
    }
    
}
