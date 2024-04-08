//
//  VerticalNftCell.swift
//  FakeNFT
//
//  Created by MAKOVEY Vladislav on 22.03.2024.
//

import Kingfisher
import UIKit

protocol IVerticalNftCellDelegate: AnyObject {
    func favoriteButtonTapped(with id: String, isFavorite: Bool)
    func cartButtonTapped(with id: String, isInCart: Bool)
}

final class VerticalNftCell: UICollectionViewCell, ReuseIdentifying {
    private enum Constant {
        static let baseCornerRadius: CGFloat = 12
        static let baseInset: CGFloat = 8

        static let productImageSize: CGFloat = 108
        static let iconSize: CGFloat = 42
        static let starsSize: CGSize = .init(width: 68, height: 12)
        static let bottomStackSize: CGFloat = 40
    }

    // MARK: - Properties

    weak var delegate: (any IVerticalNftCellDelegate)?
    private var id: String?
    private var isFavorite: Bool?
    private var isInCart: Bool = false {
        didSet {
            let isInCartIcon = isInCart ?
            Assets.inCartIcon.image :
            Assets.toCartIcon.image

            cartButton.setImage(isInCartIcon, for: .normal)
        }
    }

    // MARK: - UI

    private lazy var productImageView: ProductImageView = {
        ProductImageView { [weak self] in
            self?.isFavorite = $0
            self?.favoriteButtonTapped()
        }
    }()

    private lazy var ratingView: RatingView = {
        RatingView()
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .Body.bold
        label.textColor = .label

        return label
    }()

    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .Caption.small

        return label
    }()

    private lazy var textStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, priceLabel])
        stack.axis = .vertical
        stack.distribution = .equalCentering
        stack.spacing = 4

        return stack
    }()

    private lazy var cartButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        button.setImage(Assets.toCartIcon.image, for: .normal)
        button.addTarget(self, action: #selector(cartButtonTapped), for: .touchUpInside)

        return button.forAutolayout()
    }()

    private lazy var bottomStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [textStackView, cartButton])
        stack.axis = .horizontal
        stack.distribution = .fillProportionally

        return stack
    }()

    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }

    required init?(coder: NSCoder) { nil }

    override func prepareForReuse() {
        super.prepareForReuse()
        resetCellState()
    }

    // MARK: - Public

    func configure(model: VerticalNftCellModel) {
        setupInitialState(model: model)

        productImageView.configure(model.imagePath, isFavorite: model.isFavorite)
        setIconsToButtons(isFavorite: model.isFavorite, isInCart: model.isInCart)
        ratingView.configure(rating: model.rating)
        titleLabel.text = model.name
        priceLabel.text = "\(model.price) ETH"
    }

    // MARK: - Private

    private func setupUI() {
        productImageView.placedOn(contentView)
        NSLayoutConstraint.activate([
            productImageView.left.constraint(equalTo: contentView.left),
            productImageView.top.constraint(equalTo: contentView.top),
            productImageView.right.constraint(equalTo: contentView.right),
            productImageView.height.constraint(equalToConstant: Constant.productImageSize)
        ])

        ratingView.placedOn(contentView)
        NSLayoutConstraint.activate([
            ratingView.left.constraint(equalTo: contentView.left),
            ratingView.top.constraint(equalTo: productImageView.bottom, constant: Constant.baseInset),
            ratingView.width.constraint(equalToConstant: Constant.starsSize.width),
            ratingView.height.constraint(equalToConstant: Constant.starsSize.height)
        ])

        bottomStackView.placedOn(contentView)
        NSLayoutConstraint.activate([
            cartButton.width.constraint(equalToConstant: Constant.iconSize),
            bottomStackView.top.constraint(equalTo: ratingView.bottom, constant: 4),
            bottomStackView.left.constraint(equalTo: contentView.left),
            bottomStackView.right.constraint(equalTo: contentView.right),
            bottomStackView.height.constraint(equalToConstant: Constant.bottomStackSize)
        ])
    }

    @objc
    private func favoriteButtonTapped() {
        guard let id, let isFavorite else { return }

        delegate?.favoriteButtonTapped(with: id, isFavorite: isFavorite)
    }

    @objc
    private func cartButtonTapped() {
        guard let id else { return }
        isInCart = !isInCart

        delegate?.cartButtonTapped(with: id, isInCart: isInCart)
    }

    private func setupInitialState(model: VerticalNftCellModel) {
        id = model.id
        isFavorite = model.isFavorite
        isInCart = model.isInCart
    }

    private func setIconsToButtons(isFavorite: Bool, isInCart: Bool) {
        let isInCartIcon = isInCart ?
        Assets.inCartIcon.image :
        Assets.toCartIcon.image

        cartButton.setImage(isInCartIcon, for: .normal)
    }

    private func resetCellState() {
        productImageView.cancelDownloadImage()

        ratingView.configure(rating: 0)
        setIconsToButtons(isFavorite: false, isInCart: false)
        titleLabel.text = nil
        priceLabel.text = nil
    }
}
