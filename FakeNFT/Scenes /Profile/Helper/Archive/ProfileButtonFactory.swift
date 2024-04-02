//
//  ButtonFactory.swift
//  FakeNFT
//
//  Created by Альберт Хайдаров on 22.03.2024.
//

import UIKit

class ProfileButtonFactory: ProfileButtonFactoryProtocol {

    func createButton(with title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(Assets.ypBlack.color, for: .normal)
        button.backgroundColor = Assets.ypWhite.color

        let shevronImage = UIImage(systemName: "chevron.forward")
        button.setImage(shevronImage, for: .normal)

        setupButton(button: button)
        layoutSubviews(button: button)
        return button
    }
    private func setupButton(button: UIButton) {
        let buttonWidth = button.bounds.width
        let imageWidth = button.imageView?.bounds.width ?? .zero
        button.titleEdgeInsets = UIEdgeInsets(
            top: 0,
            left: -imageWidth,
            bottom: 0,
            right: imageWidth
        )
        button.imageEdgeInsets = UIEdgeInsets(
            top: 0,
            left: buttonWidth,
            bottom: 0,
            right: -buttonWidth
        )
    }

    private func layoutSubviews(button: UIButton) {
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 54),
            button.widthAnchor.constraint(equalToConstant: 375)
        ])
    }
}
