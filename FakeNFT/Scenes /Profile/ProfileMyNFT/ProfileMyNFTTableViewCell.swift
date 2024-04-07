//
//  ProfileFavoriteTableViewCell.swift
//  FakeNFT
//
//  Created by Альберт Хайдаров on 26.03.2024.
//
import Kingfisher
import UIKit

protocol ProfileMyNFTTableViewCellViewCellDelegate: AnyObject {
    func setFavorite(indexPath: IndexPath, isFavorite: Bool) 
}

class ProfileMyNFTTableViewCell: UITableViewCell, ReuseIdentifying {
    // MARK: - Properties

    private lazy var nftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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

    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .caption2
        label.textColor = Assets.ypBlack.color
        label.textAlignment = .left
        return label
    }()

    private lazy var nameAndRatingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(starsRatingImageView)
        stackView.addArrangedSubview(authorLabel)
        return stackView
    }()

    private lazy var priceTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .caption2
        label.text = .loc.Profile.PriceTitleLabel.title
        label.textColor = Assets.ypBlack.color
        label.textAlignment = .left
        return label
    }()

    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .bodyBold
        label.textColor = Assets.ypBlack.color
        label.textAlignment = .left
        return label
    }()

    private lazy var priceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.addArrangedSubview(priceTitleLabel)
        stackView.addArrangedSubview(priceLabel)
        return stackView
    }()

    lazy var favoriteActiveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
        return button
    }()

    private var indexPath: IndexPath?
    private var isFavorite: Bool = false

    weak var delegate: ProfileMyNFTTableViewCellViewCellDelegate?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = Assets.ypWhite.color
        setupSubview()
        layoutSetup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        nftImageView.kf.cancelDownloadTask()
        nftImageView.image = nil
        nameLabel.text = nil
        authorLabel.text = nil
        priceLabel.text = nil
    }

    // MARK: - Public
    func configureCell(with nft: MyNFTViewModel, indexPath: IndexPath, isLiked: Bool) {
        self.indexPath = indexPath
        let imagePath = nft.images[0]
        downloadImage(path: imagePath)
        nameLabel.text = nft.name
        starsRatingImageView.setRatingStars(rating: nft.rating)
        authorLabel.text = .loc.Profile.AuthorLabelText.title+" "+"\(nft.author)"
        priceLabel.text = "\(nft.price) ETH"
        setIsLiked(isLiked: isLiked)
    }

   private func setIsLiked(isLiked: Bool) {
        var favoriteActiveImage = UIImage()
        isFavorite = isLiked
        favoriteActiveImage = isLiked ? Assets.onActiveFavorites.image : Assets.noActiveFavorite.image
        self.favoriteActiveButton.setImage(favoriteActiveImage, for: .normal)
    }

    // MARK: - Private
   @objc private func likeButtonClicked() {
       if let indexPath = indexPath {
           isFavorite = !isFavorite
           delegate?.setFavorite(indexPath: indexPath, isFavorite: isFavorite)
       }
    }

    private func setupSubview() {
        contentView.addSubview(nftImageView)
        contentView.addSubview(nameAndRatingStackView)
        contentView.addSubview(priceStackView)
        contentView.addSubview(favoriteActiveButton)

        nftImageView.layer.cornerRadius = 12
        nftImageView.layer.masksToBounds = true
    }

    private func layoutSetup() {
        authorLabel.setContentHuggingPriority(.required, for: .horizontal)
        nameAndRatingStackView.setContentHuggingPriority(.defaultLow, for: .horizontal)

        NSLayoutConstraint.activate([
            nftImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nftImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nftImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            nftImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            nftImageView.heightAnchor.constraint(equalToConstant: 108),
            nftImageView.widthAnchor.constraint(equalToConstant: 108),

            favoriteActiveButton.heightAnchor.constraint(equalToConstant: 42),
            favoriteActiveButton.widthAnchor.constraint(equalToConstant: 42),
            favoriteActiveButton.topAnchor.constraint(equalTo: nftImageView.topAnchor),
            favoriteActiveButton.trailingAnchor.constraint(equalTo: nftImageView.trailingAnchor),

            nameAndRatingStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 39),
            nameAndRatingStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -39),
            nameAndRatingStackView.leadingAnchor.constraint(equalTo: nftImageView.trailingAnchor, constant: 20),
            nameAndRatingStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            authorLabel.widthAnchor.constraint(equalToConstant: 78),

            priceStackView.leadingAnchor.constraint(greaterThanOrEqualTo: nameAndRatingStackView.trailingAnchor,
                                                    constant: 39),
            priceStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -39),
            priceStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 49),
            priceStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -49)
        ])
    }

    // MARK: - Download images
    private func downloadImage(path: String) {
        guard let url = URL(string: path) else { return }
        nftImageView.kf.indicatorType = .activity
        nftImageView.kf.setImage(with: url)
    }
}
