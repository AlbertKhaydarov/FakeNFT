//
//  CatalogItem+Fake.swift
//  FakeNFTTests
//
//  Created by MAKOVEY Vladislav on 05.04.2024.
//

@testable import FakeNFT
import Foundation

// swiftlint:disable compiler_protocol_init
extension CatalogItem {
    static let fake: CatalogItem = .init(
        id: "1",
        createdAt: "2024-02-02",
        name: "Fake name",
        cover: "Fake cover",
        nfts: Set(arrayLiteral: "1", "2", "3"),
        description: "Fake description",
        author: "Fake author"
    )
}
