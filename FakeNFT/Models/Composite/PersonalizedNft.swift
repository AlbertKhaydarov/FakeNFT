//
//  PersonalizedNft.swift
//  FakeNFT
//
//  Created by MAKOVEY Vladislav on 24.03.2024.
//

import Foundation

struct PersonalizedNft: Hashable {
    let id: String
    let name: String
    let price: Decimal
    let website: String
    let imagePath: String
    let rating: Int
    let liked: Bool
    let inCart: Bool
}
