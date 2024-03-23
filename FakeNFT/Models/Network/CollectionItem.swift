//
//  CollectionItem.swift
//  FakeNFT
//
//  Created by MAKOVEY Vladislav on 22.03.2024.
//

import Foundation

struct CollectionItem: Decodable, Hashable {
    let createdAt: String
    let name: String
    let cover: String
    let nfts: [Int]
    let description: String
    let author: Int
    let id: String
}

extension CollectionItem {
    static func makeMockCollectionItem(with name: String, quantity: [Int]) -> CollectionItem {
        .init(
            createdAt: "2023-04-20T02:22:27Z",
            name: name,
            cover: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ1oryJHBLe6JqGSLEfDAvFsF5iaBzkkGKvCKDCOSqZwQ&s",
            nfts: quantity,
            description: "A series of one-of-a-kind NFTs featuring historic moments in sports history.",
            author: 49,
            id: "1"
        )
    }
}
