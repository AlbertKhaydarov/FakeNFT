//
//  ProfileFavoriteTableViewCell.swift
//  FakeNFT
//
//  Created by Альберт Хайдаров on 26.03.2024.
//
import Kingfisher
import UIKit

class ProfileFavoriteTableViewCell: UITableViewCell {

    // MARK: - Properties
    private var presenter: ProfileFavoritePresenterProtocol?
    
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
        label.text = .loc.PriceTitleLabel.title
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.presenter = nil
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
    
    func configureCell(indexPath: IndexPath, with presenter: ProfileFavoritePresenterProtocol) {
        downloadImage(path: presenter.favoritesNFT[indexPath.row].imagePath)
        nameLabel.text = presenter.favoritesNFT[indexPath.row].name
        starsRatingImageView.setRatingStars(rating: presenter.favoritesNFT[indexPath.row].starsRating)
        authorLabel.text = .loc.AuthorLabelText.title+" "+"\(presenter.favoritesNFT[indexPath.row].author)"
        priceLabel.text = "\(presenter.favoritesNFT[indexPath.row].price) ETH"
    }
    
    private func setupSubview() {
        contentView.addSubview(nftImageView)
        contentView.addSubview(nameAndRatingStackView)
        contentView.addSubview(priceStackView)

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

            nameAndRatingStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 39),
            nameAndRatingStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -39),
            nameAndRatingStackView.leadingAnchor.constraint(equalTo: nftImageView.trailingAnchor, constant: 20),
            nameAndRatingStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
//            starsRatingImageView.widthAnchor.constraint(equalToConstant: 100),
//            starsRatingImageView.heightAnchor.constraint(equalToConstant: 12),

            priceStackView.leadingAnchor.constraint(greaterThanOrEqualTo: nameAndRatingStackView.trailingAnchor, constant: 39),
            priceStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -39),
            priceStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 49),
            priceStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -49),
        ])
    }
    
    //MARK: - Download images
    private func downloadImage(path: String) {
        guard let url = URL(string: path) else { return }
        nftImageView.kf.indicatorType = .activity
        nftImageView.kf.setImage(with: url)
    }
}
