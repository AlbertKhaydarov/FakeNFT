//
//  View layout.swift
//  FakeNFT
//
//  Created by Альберт Хайдаров on 01.04.2024.
//

import UIKit

final class SubviewsLayout {
    var userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
}
