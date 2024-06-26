//
//  ProfileFavoritesViewController.swift
//  FakeNFT
//
//  Created by Альберт Хайдаров on 27.03.2024.
//

import UIKit

protocol ProfileFavoritesViewProtocol: AnyObject {
    func updateFavoritesNFTs(favoriteNFTs: [MyNFTViewModel])
    func showLoader()
    func hideLoader()
}

class ProfileFavoritesViewController: UIViewController {

    // MARK: - Constants
    private enum Constants {
        static let horizontalInset: CGFloat = 16
        static let cellSpacing: CGFloat = 7
        static let lineSpacing: CGFloat = 20

        static let cellCount: Int = 2
    }

    // MARK: - Properties
    private let presenter: any ProfileFavoritesPresenterProtocol

    private let params = GeometricParams(
        cellCount: Constants.cellCount,
        leftInset: Constants.horizontalInset,
        rightInset: Constants.horizontalInset,
        cellSpacing: Constants.cellSpacing,
        lineSpacingForSectionAt: Constants.lineSpacing)

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ProfileFavoritesCollectionViewCell.self)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = Assets.ypWhite.color
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()

    private lazy var stubFavotitesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .Body.bold
        label.textColor = Assets.ypBlack.color
        label.textAlignment = .center
        label.text = .loc.Profile.StubFavotitesLabel.title
        label.isHidden = false
        return label
    }()

    private var favoriteNFTs: [MyNFTViewModel]?

    init(presenter: some ProfileFavoritesPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { nil }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = .loc.Profile.FavoriteNFTButton.title
        view.backgroundColor = Assets.ypWhite.color
        presenter.viewDidLoad()
        isStubHidden()
        setupSubviews()
        layoutSubviews()
    }

    func updateFavoritesNFTs(favoriteNFTs: [MyNFTViewModel]) {
        self.favoriteNFTs = favoriteNFTs
        isStubHidden()
        collectionView.reloadData()
    }

    private func setupSubviews() {
        view.addSubview(collectionView)
        view.addSubview(stubFavotitesLabel)
    }

    private func isStubHidden() {
        if favoriteNFTs?.count == 0 {
            stubFavotitesLabel.isHidden = false
        } else {
            stubFavotitesLabel.isHidden = true
        }
    }

    private func layoutSubviews() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            stubFavotitesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stubFavotitesLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stubFavotitesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                        constant: Constants.horizontalInset),
            stubFavotitesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                         constant: -Constants.horizontalInset)
        ])
    }

    func showLoader() {
        UIBlockingProgressHUD.show()
    }

    func hideLoader() {
        UIBlockingProgressHUD.dismiss()
    }
}

// MARK: - ProfileFavoritesViewProtocol
// MARK: - TBD in the 2nd part
extension ProfileFavoritesViewController: ProfileFavoritesViewProtocol { }

// MARK: - UICollectionViewDataSource
extension ProfileFavoritesViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let favoriteNFTs = self.favoriteNFTs else {return 0}
        return favoriteNFTs.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ProfileFavoritesCollectionViewCell = collectionView.dequeueReusableCell(indexPath: indexPath)
        cell.delegate = self
        if let favoriteNFTs = favoriteNFTs {
            cell.configureCell(indexPath: indexPath, with: favoriteNFTs)
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout & UICollectionViewDelegate

extension ProfileFavoritesViewController: UICollectionViewDelegateFlowLayout & UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.bounds.width - params.paddingWidth) / CGFloat(params.cellCount)
        let heightCell = cellWidth * 80 / 168
        return CGSize(width: cellWidth, height: heightCell)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: params.lineSpacingForSectionAt,
                     left: params.leftInset,
                     bottom: params.lineSpacingForSectionAt,
                     right: params.rightInset)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return params.cellSpacing
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return params.lineSpacingForSectionAt
    }
}

// MARK: - ProfileFavoritesCollectionViewCellDelegate

extension ProfileFavoritesViewController: ProfileFavoritesCollectionCellDelegate {
    func favoriteCancell(indexPath: IndexPath) {
        self.favoriteNFTs?.remove(at: indexPath.row)
        presenter.updateProfile(favorites: self.favoriteNFTs)
        isStubHidden()
        collectionView.reloadData()
    }
}
