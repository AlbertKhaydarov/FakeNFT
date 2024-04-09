//
//  MockName.swift
//  FakeNFT
//
//  Created by Альберт Хайдаров on 09.04.2024.
//

import Foundation

struct Name {
    let names: [String]

    static var currentIndex = 0
}

extension Name {
    static var items = Name(names: [
    "Aurora",
    "Bimbo",
    "Biscuit",
    "Breena",
    "Buster",
    "Corbin",
    "Cupid",
    "Dingo",
    "Ellsa",
    "Finn",
    "Gus",
    "Lark",
    "Lucky",
    "Melvin",
    "Nala",
    "Penny",
    "Ralph",
    "Salena",
    "Simba",
    "Whisper"
    ])

   static func getName() -> String {
       let name = items.names[currentIndex]
       if currentIndex < items.names.count - 1 {
           currentIndex += 1
        } else {
            currentIndex = 0
        }
        return name
    }
}
