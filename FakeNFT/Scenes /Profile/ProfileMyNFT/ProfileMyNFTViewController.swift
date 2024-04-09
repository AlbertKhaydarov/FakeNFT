//
//  ProfileFavoriteViewController.swift
//  FakeNFT
//
//  Created by Альберт Хайдаров on 26.03.2024.
//

import UIKit

protocol ProfileMyNFTViewProtocol: AnyObject {
    func updateMyNFTs(myNFTs: [MyNFTViewModel])
    func showLoader()
    func hideLoader()
}

class ProfileMyNFTViewController: UIViewController {

    // MARK: - Constants
    private enum Constants {
        static let tableViewVerticalConstraint: CGFloat = 20
        static let stubMyNFTLabelHorizontalConstraint: CGFloat = 16
    }

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

    private func sortButton() {
        let rightButton = UIBarButtonItem(image: Assets.sortImage.image,
                                          style: .plain,
                                          target: self,
                                          action: #selector(sortButtonTapped))
        self.navigationItem.rightBarButtonItem = rightButton
        rightButton.tintColor = Assets.ypBlack.color
    }

    @objc
    private func sortButtonTapped() {
        presenter.sortButtonTapped()
    }

    private func setupSubview() {
        view.addSubview(tableView)
        view.addSubview(stubMyNFTLabel)
    }

    private func layoutSubviews() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                           constant: Constants.tableViewVerticalConstraint),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                              constant: -Constants.tableViewVerticalConstraint),

            stubMyNFTLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stubMyNFTLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stubMyNFTLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                    constant: Constants.stubMyNFTLabelHorizontalConstraint),
            stubMyNFTLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                     constant: -Constants.stubMyNFTLabelHorizontalConstraint)
        ])
    }

    func showLoader() {
        UIBlockingProgressHUD.show()
    }

    func hideLoader() {
        UIBlockingProgressHUD.dismiss()
    }
}

// MARK: - ProfileMyNFTViewProtocol

extension ProfileMyNFTViewController: ProfileMyNFTViewProtocol {
    func showSortingAlert() {
        let alertController = UIAlertController(
            title: .loc.Profile.Alert.title,
            message: nil,
            preferredStyle: .actionSheet
        )
//
        let byPriceAction = UIAlertAction(
            title: .loc.Profile.AlertAction1.title,
            style: .default,
            handler: { [weak self] _ in
                self?.presenter.sortByPrice()
            }
        )
//        byPriceAction.accessibilityIdentifier = AccessibilityConstant.sortItemByName

        let byRatingAction = UIAlertAction(
            title: .loc.Profile.AlertAction2.title,
            style: .default,
            handler: { [weak self] _ in
                self?.presenter.sortByRatingAction()
            }
        )
//        byRatingAction.accessibilityIdentifier = AccessibilityConstant.sortItemByNft

        let byNameAction = UIAlertAction(
            title: .loc.Profile.AlertAction3.title,
            style: .default,
            handler: { [weak self] _ in
                self?.presenter.sortByNameAction()
            }
        )

//        byNameAction.accessibilityIdentifier = AccessibilityConstant.sortItemByNft.accessibilityIdentifier = AccessibilityConstant.sortItemByNft
        
        let cancelAction = UIAlertAction(
            title: .loc.Profile.AlertCloseAction.title,
            style: .cancel
        )

        alertController.addAction(byPriceAction)
        alertController.addAction(byRatingAction)
        alertController.addAction(byNameAction)
        alertController.addAction(cancelAction)
//        alertController.view.accessibilityIdentifier = AccessibilityConstant.sortingAlert
        present(alertController, animated: true)
    }
}

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
            cell.configureCell(with: item, indexPath: indexPath, isLiked: item.isLiked)
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

extension ProfileMyNFTViewController: ProfileMyNFTTableViewCellDelegate {
    func setFavorite(indexPath: IndexPath, isFavorite: Bool) {
        guard let myNFTs = myNFTs else {return}

        let nft = MyNFTViewModel(createdAt: myNFTs[indexPath.row].createdAt,
                                 name: myNFTs[indexPath.row].name,
                                 images: myNFTs[indexPath.row].images,
                                 rating: myNFTs[indexPath.row].rating,
                                 description: myNFTs[indexPath.row].description,
                                 price: myNFTs[indexPath.row].price,
                                 author: myNFTs[indexPath.row].author,
                                 id: myNFTs[indexPath.row].id,
                                 isLiked: isFavorite)
        presenter.setFavorite(with: nft, isFavorite: isFavorite)
    }
}
