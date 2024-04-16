//
//  ProfileViewModel.swift
//  FakeNFT
//
//  Created by Альберт Хайдаров on 27.03.2024.
//

import Foundation

struct ProfileViewModel: Decodable {
    let name: String
    let userPic: String
    let description: String
    let website: String
    let nfts: [String]
    let likes: [String]
    let id: String
}
