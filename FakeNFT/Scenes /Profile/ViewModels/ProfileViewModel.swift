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
}

// MARK: - Mock data
// swiftlint:disable all
//extension ProfileViewModel {
//    static func getProfile() -> ProfileViewModel {
//        .init(
//            name: "IOS разработчик",
//            userPic: "https://careers.itmo.ru/images/company/small/logo_756.png",
//            description:
//            "Групповой проект, чтобы научиться работать в команде. That’s one small step for man. One giant leap for mankind",
//            website: "https://practicum.yandex.ru/ios-developer"
//        )
//    }
//}
// swiftlint:enable all
