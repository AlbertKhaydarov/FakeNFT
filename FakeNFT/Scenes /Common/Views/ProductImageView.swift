//
//  ProductImageView.swift
//  FakeNFT
//
//  Created by MAKOVEY Vladislav on 22.03.2024.
//

import Kingfisher
import UIKit

final class ProductImageView: UIView {
    enum Constant {
        static let baseCornerRadius: CGFloat = 12
        static let iconSize: CGFloat = 42
    }

    // MARK: - Properties

    private var isFavorite = false {
        didSet {
            let favoriteIconColor = isFavorite ?
            Assets.ypRedUniversal.color:
            Assets.ypWhiteUniversal.color

            favoriteButton.tintColor = favoriteIconColor
        }
    }

    private let action: (Bool) -> Void

    // MARK: - UI

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = Constant.baseCornerRadius
        imageView.isUserInteractionEnabled = false

        return imageView
    }()

    private lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(Assets.favoriteIcon.image, for: .normal)
        button.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)

        return button
    }()

    // MARK: - Lifecycle

    init(action: @escaping (Bool) -> Void) {
        self.action = action

        super.init(frame: .zero)

        setupUI()
    }

    required init?(coder: NSCoder) { nil }

    // MARK: - Public

    func configure(_ imagePath: String, isFavorite: Bool) {
        self.isFavorite = isFavorite
        downLoadImage(imagePath)
    }

    func cancelDownloadImage() {
        isFavorite = false
        imageView.kf.cancelDownloadTask()
        imageView.image = nil
    }

    private func downLoadImage(_ imagePath: String) {
        guard let url = URL(string: imagePath) else { return }
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: url)
    }

    // MARK: - Private

    private func setupUI() {
        imageView
            .placedOn(self)
            .pin(to: self)

        favoriteButton.placedOn(self)
        NSLayoutConstraint.activate([
            favoriteButton.width.constraint(equalToConstant: Constant.iconSize),
            favoriteButton.height.constraint(equalToConstant: Constant.iconSize),
            favoriteButton.top.constraint(equalTo: imageView.top),
            favoriteButton.right.constraint(equalTo: imageView.right)
        ])

    }

    @objc
    private func favoriteButtonTapped() {
        isFavorite = !isFavorite
        action(isFavorite)
    }
}
