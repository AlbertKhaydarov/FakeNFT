//
//  ProfileMyNFT.swift
//  FakeNFT
//
//  Created by Альберт Хайдаров on 29.03.2024.
//

import Foundation

struct ProfileMyNFT: Decodable {
    let createdAt: String
    let name: String
    let images: [String]
    let rating: Int
    let description: String
    let price: Decimal
    let author: String
    let id: String
}
