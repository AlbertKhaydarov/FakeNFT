//
//  RatingView.swift
//  FakeNFT
//
//  Created by MAKOVEY Vladislav on 22.03.2024.
//

import UIKit

final class RatingView: UIView {
    // MARK: - UI

    private let stars: [UIImageView] = {
        var imageViews = [UIImageView]()

        for i in 1...5 {
            imageViews.append(UIImageView(image: Assets.startIcon.image))
        }
        return imageViews
    }()

    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: stars)
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.spacing = 2

        return stack.forAutolayout()
    }()

    // MARK: - Lifecycle

    init() {
        super.init(frame: .zero)

        setupUI()
    }

    required init?(coder: NSCoder) { nil }

    // MARK: - Public

    func configure(rating: Int) {
        stars.enumerated().forEach { index, star in
            star.tintColor = rating > index ? Assets.ypYellowUniversal.color : Assets.ypLightGrey.color
        }
    }

    // MARK: - Private

    private func setupUI() {
        stackView
            .placedOn(self)
            .pin(to: self)
    }
}
