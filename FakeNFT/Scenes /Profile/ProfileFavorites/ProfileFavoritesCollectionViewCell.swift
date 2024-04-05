//
//  ProfileFavoritesCollectionViewCell.swift
//  FakeNFT
//
//  Created by Альберт Хайдаров on 27.03.2024.
//

import UIKit

protocol ProfileFavoritesCollectionViewCellDelegate: AnyObject {
    func favoriteCancell(indexPath: IndexPath)
}

class ProfileFavoritesCollectionViewCell: UICollectionViewCell, ReuseIdentifying {

    private lazy var nftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var favoriteActiveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
        button.setImage(Assets.onActiveFavorites.image , for: .normal)
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
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(starsRatingImageView)
        stackView.addArrangedSubview(priceLabel)
        return stackView
    }()
    
    private var indexPath: IndexPath?
    
    weak var delegate: ProfileFavoritesCollectionViewCellDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        setupCellLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func configureCell(with nfts: MyNFTViewModel) {
//        downloadImage(path: nfts.imagePath)
//        nameLabel.text = nfts.name
//        starsRatingImageView.setRatingStars(rating: nfts.starsRating)
//        priceLabel.text = "\(nfts.price) ETH"
//    }

    func configureCell(indexPath: IndexPath, with nfts: [MyNFTViewModel]) {
        downloadImage(path: nfts[indexPath.row].imagePath)
        nameLabel.text = nfts[indexPath.row].name
        starsRatingImageView.setRatingStars(rating: nfts[indexPath.row].starsRating)
        priceLabel.text = "\(nfts[indexPath.row].price) ETH"
        self.indexPath = indexPath
//        setIsLiked(isLiked: presenter.favoritesNFT[indexPath.row].isFavorite)
    }

    @objc private func likeButtonClicked() {
        guard let indexPath = indexPath else {return}
        delegate?.favoriteCancell(indexPath: indexPath)
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
            commonStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            commonStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            commonStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7),
            commonStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -7)
        ])
    }

    // MARK: - Download images
    private func downloadImage(path: String) {
        guard let url = URL(string: path) else { return }
        nftImageView.kf.indicatorType = .activity
        nftImageView.kf.setImage(with: url)
    }
}
