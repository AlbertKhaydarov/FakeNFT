//
//  ProfileFavoritesCollectionViewCell.swift
//  FakeNFT
//
//  Created by Альберт Хайдаров on 27.03.2024.
//

import UIKit

class ProfileFavoritesCollectionViewCell: UICollectionViewCell {

    static let profileFavoritesCellIdentifier = String(describing: ProfileFavoritesCollectionViewCell.self)

    private lazy var nftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var favoriteActiveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
        return button
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .bodyBold
        label.textColor = Assets.ypBlack.color
        label.textAlignment = .left
        return label
    }()

    private lazy var starsRatingImageView: RatingStarsView = {
        let imageView = RatingStarsView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .caption1
        label.textColor = Assets.ypBlack.color
        label.textAlignment = .left
        return label
    }()

    private lazy var commonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.distribution = .equalCentering
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(starsRatingImageView)
        stackView.addArrangedSubview(priceLabel)
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        setupCellLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureCell(indexPath: IndexPath, with presenter: ProfileFavoritesPresenterProtocol) {
        downloadImage(path: presenter.favoritesNFT[indexPath.row].imagePath)
        nameLabel.text = presenter.favoritesNFT[indexPath.row].name
        starsRatingImageView.setRatingStars(rating: presenter.favoritesNFT[indexPath.row].starsRating)
        priceLabel.text = "\(presenter.favoritesNFT[indexPath.row].price) ETH"
        setIsLiked(isLiked: presenter.favoritesNFT[indexPath.row].isFavorite)
    }

    @objc private func likeButtonClicked() {
        // MARK: - TBD in 2nd part
    }

    func setIsLiked(isLiked: Bool) {
        var favoriteActiveImage = UIImage()
        favoriteActiveImage = isLiked ? Assets.onActiveFavorites.image : Assets.noActiveFavorite.image
        self.favoriteActiveButton.setImage(favoriteActiveImage, for: .normal)
    }

    private func setupCell() {
        self.backgroundColor = .clear
        contentView.addSubview(nftImageView)
        contentView.addSubview(favoriteActiveButton)
        contentView.addSubview(commonStackView)

        nftImageView.layer.cornerRadius = 12
        nftImageView.layer.masksToBounds = true
    }

    private func setupCellLayout() {
        NSLayoutConstraint.activate([
            nftImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nftImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nftImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            nftImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            nftImageView.heightAnchor.constraint(equalToConstant: 80),
            nftImageView.widthAnchor.constraint(equalToConstant: 80),

            favoriteActiveButton.heightAnchor.constraint(equalToConstant: 42),
            favoriteActiveButton.widthAnchor.constraint(equalToConstant: 42),
            favoriteActiveButton.topAnchor.constraint(equalTo: nftImageView.topAnchor),
            favoriteActiveButton.trailingAnchor.constraint(equalTo: nftImageView.trailingAnchor),

            commonStackView.leadingAnchor.constraint(equalTo: nftImageView.trailingAnchor, constant: 12),
            commonStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            commonStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7),
            commonStackView.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -7)
        ])
    }

    // MARK: - Download images
    private func downloadImage(path: String) {
        guard let url = URL(string: path) else { return }
        nftImageView.kf.indicatorType = .activity
        nftImageView.kf.setImage(with: url)
    }
}
