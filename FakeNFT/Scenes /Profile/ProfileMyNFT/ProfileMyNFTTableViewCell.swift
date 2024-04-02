//
//  ProfileFavoriteTableViewCell.swift
//  FakeNFT
//
//  Created by Альберт Хайдаров on 26.03.2024.
//
import Kingfisher
import UIKit

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
        stackView.distribution = .equalCentering
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
        stackView.distribution = .equalCentering
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
    func configureCell(with nft: MyNFTViewModel) {
        downloadImage(path: nft.imagePath)
        nameLabel.text = nft.name
        nameLabel.text = nft.imagePath
        starsRatingImageView.setRatingStars(rating: nft.starsRating)
        authorLabel.text = .loc.Profile.AuthorLabelText.title+" "+"\(nft.author)"
        priceLabel.text = "\(nft.price) ETH"
        setIsLiked(isLiked: nft.isFavorite)

//        downloadImage(path: nft.imagePath) { image in
//                DispatchQueue.main.async {
//                    self.nftImageView.image = image
//                }
//            }
     
    }

    func setIsLiked(isLiked: Bool) {
        var favoriteActiveImage = UIImage()
        favoriteActiveImage = isLiked ? Assets.onActiveFavorites.image : Assets.noActiveFavorite.image
        self.favoriteActiveButton.setImage(favoriteActiveImage, for: .normal)
    }

    // MARK: - Private
   @objc private func likeButtonClicked() {
        // MARK: - TBD in 2nd part
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
//    private func downloadImage(path: String, completion: @escaping (UIImage?) -> Void) {
//        guard let url = URL(string: path) else { return }
//        nftImageView.kf.indicatorType = .activity
//        nftImageView.kf.setImage(with: url) { result in
//            switch result {
//            case .success(let value):
//                completion(value.image)
//            case .failure(let error):
//                print("Error downloading image: \(error)")
//                completion(nil)
//            }
//        }
//    }

}
