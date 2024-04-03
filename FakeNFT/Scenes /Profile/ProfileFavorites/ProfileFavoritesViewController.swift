//
//  ProfileFavoritesViewController.swift
//  FakeNFT
//
//  Created by Альберт Хайдаров on 27.03.2024.
//

import UIKit

protocol ProfileFavoritesViewProtocol: AnyObject {
    func updateFavoritesNFTs(favoriteNFTs: [MyNFTViewModel])
}

class ProfileFavoritesViewController: UIViewController {

    // MARK: - Properties
    private let presenter: any ProfileFavoritesPresenterProtocol

    private let params = GeometricParams(
        cellCount: 2,
        leftInset: 16,
        rightInset: 16,
        cellSpacing: 7,
        lineSpacingForSectionAt: 20)

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
        label.font = .bodyBold
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
        presenter.viewDidLoad()
        isStubHidden()
        setupSubviews()
        layoutSubviews()
    }

    func updateFavoritesNFTs(favoriteNFTs: [MyNFTViewModel]) {
        self.favoriteNFTs = favoriteNFTs
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
            stubFavotitesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stubFavotitesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
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
//            withReuseIdentifier:  ProfileFavoritesCollectionViewCell.defaultReuseIdentifier,
//            for: indexPath) as? ProfileFavoritesCollectionViewCell
        if let favoriteNFTs = favoriteNFTs {
            let item = favoriteNFTs[indexPath.row]
            cell.configureCell(with: item)
//            cell.configureCell(indexPath: indexPath, with: presenter)
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