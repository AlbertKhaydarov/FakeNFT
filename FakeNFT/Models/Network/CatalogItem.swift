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
    let nfts: Set<String>
    let description: String
    let author: String
}
