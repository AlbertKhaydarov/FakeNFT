//
//  ProfileInfoRequest.swift
//  FakeNFT
//
//  Created by MAKOVEY Vladislav on 31.03.2024.
//

import Foundation

struct ProfileInfoRequest: Encodable {
    let name: String
    let description: String
    let website: String
    let likes: [String]
}
