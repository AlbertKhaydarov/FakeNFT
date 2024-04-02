//
//  FavoritesViewModel.swift
//  FakeNFT
//
//  Created by Альберт Хайдаров on 26.03.2024.
//

import Foundation

struct MyNFTViewModel {
    let name: String
    let imagePath: String
    let starsRating: Int
    let author: String
    let price: Decimal
    let isFavorite: Bool
}

// MARK: - Mock data
extension MyNFTViewModel {
    static func getNFT() -> MyNFTViewModel {
        .init(
            name: "Nft",
            imagePath: "https://bankruptcy-ua.com/assets_images/publication/19478/photo_originals.jpg",
            starsRating: 4,
            author: "John Doe",
            price: 1.78,
            isFavorite: true)
    }
}
