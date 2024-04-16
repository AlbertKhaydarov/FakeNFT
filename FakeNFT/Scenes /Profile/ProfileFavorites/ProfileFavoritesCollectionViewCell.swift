//
//  ProfileFavoritesCollectionViewCell.swift
//  FakeNFT
//
//  Created by Альберт Хайдаров on 27.03.2024.
//

import UIKit

protocol ProfileFavoritesCollectionCellDelegate: AnyObject {
    func favoriteCancell(indexPath: IndexPath)
}

class ProfileFavoritesCollectionViewCell: UICollectionViewCell, ReuseIdentifying {

    // MARK: - Constants
    private enum Constants {
        static let baseSpacing: CGFloat = 4
        static let baseCornerRadius: CGFloat = 12
        static let imageSize: CGFloat = 80
        static let buttonSize: CGFloat = 42
        static let commonStackViewLeft: CGFloat = 12
        static let commonStackViewVertical: CGFloat = 7
    }

    private lazy var nftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var favoriteActiveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
        button.setImage(Assets.onActiveFavorites.image, for: .normal)
        return button
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .Body.bold
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
        label.font = .Caption.large
        label.textColor = Assets.ypBlack.color
        label.textAlignment = .left
        return label
    }()

    private lazy var commonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Constants.baseSpacing
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(starsRatingImageView)
        stackView.addArrangedSubview(priceLabel)
        return stackView
    }()

    private var indexPath: IndexPath?

    weak var delegate: ProfileFavoritesCollectionCellDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        setupCellLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureCell(indexPath: IndexPath, with nfts: [MyNFTViewModel]) {
        let imagePath = nfts[indexPath.row].images[0]
        downloadImage(path: imagePath)
        nameLabel.text = nfts[indexPath.row].name
        starsRatingImageView.setRatingStars(rating: nfts[indexPath.row].rating)
        priceLabel.text = "\(nfts[indexPath.row].price) ETH"
        self.indexPath = indexPath
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

        nftImageView.layer.cornerRadius = Constants.baseCornerRadius
        nftImageView.layer.masksToBounds = true
    }

    private func setupCellLayout() {
        NSLayoutConstraint.activate([
            nftImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nftImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nftImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            nftImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            nftImageView.heightAnchor.constraint(equalToConstant: Constants.imageSize),
            nftImageView.widthAnchor.constraint(equalToConstant: Constants.imageSize),

            favoriteActiveButton.heightAnchor.constraint(equalToConstant: Constants.buttonSize),
            favoriteActiveButton.widthAnchor.constraint(equalToConstant: Constants.buttonSize),
            favoriteActiveButton.topAnchor.constraint(equalTo: nftImageView.topAnchor),
            favoriteActiveButton.trailingAnchor.constraint(equalTo: nftImageView.trailingAnchor),

            commonStackView.leadingAnchor.constraint(equalTo: nftImageView.trailingAnchor,
                                                     constant: Constants.commonStackViewLeft),
            commonStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            commonStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            commonStackView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                                 constant: Constants.commonStackViewVertical),
            commonStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                                    constant: -Constants.commonStackViewVertical)
        ])
    }

    // MARK: - Download images
    private func downloadImage(path: String) {
        guard let url = URL(string: path) else { return }
        nftImageView.kf.indicatorType = .activity
        nftImageView.kf.setImage(with: url)
    }
}
