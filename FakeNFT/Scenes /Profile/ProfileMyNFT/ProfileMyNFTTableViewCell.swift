//
//  ProfileFavoriteTableViewCell.swift
//  FakeNFT
//
//  Created by Альберт Хайдаров on 26.03.2024.
//
import Kingfisher
import UIKit

protocol ProfileMyNFTTableViewCellDelegate: AnyObject {
    func setFavorite(indexPath: IndexPath, isFavorite: Bool)
}

class ProfileMyNFTTableViewCell: UITableViewCell, ReuseIdentifying {

    // MARK: - Constants
    private enum Constants {
        static let baseSpacing: CGFloat = 4
        static let baseCornerRadius: CGFloat = 12
        static let horizontalConstraint: CGFloat = 16
        static let nftImageViewSize: CGFloat = 108
        static let favoriteActiveButtonSize: CGFloat = 42
        static let stackViewVerticalConstraint: CGFloat = 39
        static let stackViewRightConstraint: CGFloat = 20
        static let authorLabelWidth: CGFloat = 78
        static let priceStackViewVertical: CGFloat = 49
    }

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
        stackView.spacing = Constants.baseSpacing
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
        stackView.spacing = Constants.baseSpacing / 2
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

    weak var delegate: ProfileMyNFTTableViewCellDelegate?

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

        nftImageView.layer.cornerRadius = Constants.baseCornerRadius
        nftImageView.layer.masksToBounds = true
    }

    private func layoutSetup() {
        authorLabel.setContentHuggingPriority(.required, for: .horizontal)
        nameAndRatingStackView.setContentHuggingPriority(.defaultLow, for: .horizontal)

        NSLayoutConstraint.activate([
            nftImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                  constant: Constants.horizontalConstraint),
            nftImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nftImageView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                              constant: Constants.horizontalConstraint),
            nftImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                                 constant: -Constants.horizontalConstraint),
            nftImageView.heightAnchor.constraint(equalToConstant: Constants.nftImageViewSize),
            nftImageView.widthAnchor.constraint(equalToConstant: Constants.nftImageViewSize),

            favoriteActiveButton.heightAnchor.constraint(equalToConstant: Constants.favoriteActiveButtonSize),
            favoriteActiveButton.widthAnchor.constraint(equalToConstant: Constants.favoriteActiveButtonSize),
            favoriteActiveButton.topAnchor.constraint(equalTo: nftImageView.topAnchor),
            favoriteActiveButton.trailingAnchor.constraint(equalTo: nftImageView.trailingAnchor),

            nameAndRatingStackView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                                        constant: Constants.stackViewVerticalConstraint),
            nameAndRatingStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                                           constant: -Constants.stackViewVerticalConstraint),
            nameAndRatingStackView.leadingAnchor.constraint(equalTo: nftImageView.trailingAnchor,
                                                            constant: Constants.stackViewRightConstraint),
            nameAndRatingStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            authorLabel.widthAnchor.constraint(equalToConstant: Constants.authorLabelWidth),

            priceStackView.leadingAnchor.constraint(greaterThanOrEqualTo: nameAndRatingStackView.trailingAnchor,
                                                    constant: Constants.stackViewVerticalConstraint),
            priceStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                     constant: -Constants.stackViewVerticalConstraint),
            priceStackView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                                constant: Constants.priceStackViewVertical),
            priceStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                                   constant: -Constants.priceStackViewVertical)
        ])
    }

    // MARK: - Download images
    private func downloadImage(path: String) {
        guard let url = URL(string: path) else { return }
        nftImageView.kf.indicatorType = .activity
        nftImageView.kf.setImage(with: url)
    }
}
