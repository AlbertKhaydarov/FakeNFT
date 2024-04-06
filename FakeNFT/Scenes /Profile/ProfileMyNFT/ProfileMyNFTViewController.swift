//
//  ProfileFavoriteViewController.swift
//  FakeNFT
//
//  Created by Альберт Хайдаров on 26.03.2024.
//

import UIKit

protocol ProfileMyNFTViewProtocol: AnyObject { 
    func updateMyNFTs(myNFTs: [MyNFTViewModel])
}

class ProfileMyNFTViewController: UIViewController {

    // MARK: - Properties
    private let presenter: any ProfileMyNFTPresenterProtocol

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = Assets.ypWhite.color
        tableView.register(ProfileMyNFTTableViewCell.self)
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

    private var myNFTs: [MyNFTViewModel]?

    init(presenter: some ProfileMyNFTPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { nil }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        view.backgroundColor = Assets.ypWhite.color
        title = .loc.Profile.MyNFTButton.title
        setupSubview()
        layoutSubviews()
        sortButton()
        isStubHidden()
    }

    func updateMyNFTs(myNFTs: [MyNFTViewModel]) {
        self.myNFTs = myNFTs
        tableView.reloadData()
    }

    // MARK: - Private
    private func isStubHidden() {
        if myNFTs?.count == 0 {
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
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),

            stubMyNFTLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stubMyNFTLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stubMyNFTLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stubMyNFTLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
}

// MARK: - ProfileMyNFTViewProtocol

// MARK: - TBD in the 2nd part
extension ProfileMyNFTViewController: ProfileMyNFTViewProtocol {}

// MARK: - UITableViewDataSource
extension ProfileMyNFTViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let myNFTs = self.myNFTs else {return 0}
        return myNFTs.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ProfileMyNFTTableViewCell = tableView.dequeueReusableCell()
        cell.delegate = self
        if let myNFTs = myNFTs {
            let item = myNFTs[indexPath.row]
            cell.configureCell(with: item, indexPath: indexPath, isLiked: item.isLiked/*, with: presenter*/)
        }
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ProfileMyNFTViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140.0
    }
}

// MARK: - ProfileFavoritesCollectionViewCellDelegate

extension ProfileMyNFTViewController: ProfileMyNFTTableViewCellViewCellDelegate {
    
    func setFavorite(indexPath: IndexPath) {
        guard let myNFTs = myNFTs else {return}
        let nft = myNFTs[indexPath.row]
        presenter.setFavorite(with: nft)
    }
}
