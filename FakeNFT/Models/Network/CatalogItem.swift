//
//  CatalogItem.swift
//  FakeNFT
//
//  Created by MAKOVEY Vladislav on 22.03.2024.
//

import Foundation

struct CatalogItem: Decodable {
    let id: String
    let createdAt: String
    let name: String
    let cover: String
    let nfts: [String]
    let description: String
    let author: String
}

extension CatalogItem {
    static func makeMockCollectionItem(with name: String, quantity: [String]) -> CatalogItem {
        .init(
            id: "1",
            createdAt: "2023-04-20T02:22:27Z",
            name: name,
            cover: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ1oryJHBLe6JqGSLEfDAvFsF5iaBzkkGKvCKDCOSqZwQ&s",
            nfts: quantity,
            description: "A series of one-of-a-kind NFTs featuring historic moments in sports history.",
            author: "Darren Morris"
        )
    }
}
