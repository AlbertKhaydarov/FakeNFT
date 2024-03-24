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

extension Order {
    static func makeMockOrder() -> Order {
        .init(nfts: ["1", "3", "5"], id: "1")
    }
}
