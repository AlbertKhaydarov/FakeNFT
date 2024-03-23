//
//  ProfileInfo.swift
//  FakeNFT
//
//  Created by MAKOVEY Vladislav on 23.03.2024.
//

import Foundation

struct ProfileInfo {
    let name: String
    let avatar: String
    let description: String
    let website: String
    let nfts: [String]
    let likes: [String]
    let id: String
}

extension ProfileInfo {
    static func makeProductInfo() -> ProfileInfo {
        .init(
            name: "Студентус Практикумус",
            avatar: "https://code.s3.yandex.net/landings-v2-ios-developer/space.PNG",
            description: "Прошел 5-й спринт, и этот пройду",
            website: "https://practicum.yandex.ru/ios-developer",
            nfts: ["1", "2", "3"],
            likes: ["1", "2", "3"],
            id: "1"
        )
    }
}
