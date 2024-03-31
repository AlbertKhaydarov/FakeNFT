//
//  ProfileInfo.swift
//  FakeNFT
//
//  Created by MAKOVEY Vladislav on 23.03.2024.
//

import Foundation

struct ProfileInfo: Decodable {
    let name: String
    let avatar: String
    let description: String
    let website: String
    let nfts: [String]
    let likes: [String]
    let id: String
}
