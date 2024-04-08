//
//  ProfileTestData.swift
//  FakeNFTTests
//
//  Created by Альберт Хайдаров on 08.04.2024.
//

@testable import FakeNFT
import Foundation

// swiftlint:disable compiler_protocol_init
extension Profile {
    static let testProfileData: Profile = Profile(name: "Студент 11-й когорты",
                                                  avatar: "https://heaclub.ru/tim/a72cf0aef9201409c0ede11855ac2b18/kartinka-na-avu-dlya-parnei-prikolnaya.jpg",
                                                  description: "Привет!",
                                                  website: "https://practicum.yandex.ru/graphic-designer/",
                                                  nfts: ["e8c1f0b6-5caf-4f65-8e5b-12f4bcb29efb"],
                                                  likes: ["e8c1f0b6-5caf-4f65-8e5b-12f4bcb29efb"],
                                                  id: "1e07d999-5de3-47b6-bd74-a643c4d395e4")
}
