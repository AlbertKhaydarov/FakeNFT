//
//  Order.swift
//  FakeNFT
//
//  Created by MAKOVEY Vladislav on 23.03.2024.
//

import Foundation

struct Order: Decodable {
    let nfts: [String]
    let id: String
}
