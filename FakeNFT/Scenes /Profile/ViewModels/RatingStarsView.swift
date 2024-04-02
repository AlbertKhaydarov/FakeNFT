//
//  RatingStarsView.swift
//  FakeNFT
//
//  Created by Альберт Хайдаров on 26.03.2024.
//

import UIKit

final class RatingStarsView: UIView {

    private var starImageViews: [UIImageView] = []

    init() {
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setRatingStars(rating: Int) {
        for item in 0..<rating {
            starImageViews.append(UIImageView(image: Assets.onActiveStarImage.image))
            starImageViews[item].tintColor = Assets.ypYellowUniversal.color
        }
        for item in rating..<5 {
            starImageViews.append(UIImageView(image: Assets.noActiveStarImage.image))
            starImageViews[item].tintColor = Assets.ypLightGrey.color
        }
        getStackView()
    }

    private func getStackView() {
        let stackView = UIStackView(arrangedSubviews: starImageViews)
        stackView.axis  = .horizontal
        stackView.spacing = 2
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        setupSubviews(stackView: stackView)
        layoutSetup(stackView: stackView)
    }

    private func setupSubviews(stackView: UIStackView) {
        self.addSubview(stackView)
    }

    private func layoutSetup(stackView: UIStackView) {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        ])
    }
}
