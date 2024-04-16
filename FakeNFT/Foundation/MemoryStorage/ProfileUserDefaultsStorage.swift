//
//  UserDefaultsStorage.swift
//  FakeNFT
//
//  Created by Альберт Хайдаров on 08.04.2024.
//

import Foundation

enum SortProfileSortType: String {
    case byPrice
    case byRating
    case byName
    case none
}

protocol ProfileUserDefaultsStorageProtocol {
    var chosenTypeSort: SortProfileSortType { get set }
}

struct ProfileUserDefaultsStorage: ProfileUserDefaultsStorageProtocol {
    private enum Constant {
        static let key = "myNFTsSort"
    }

    // MARK: - Properties

    private let userDefaults = UserDefaults.standard

    var chosenTypeSort: SortProfileSortType {
        get {
            if let value = userDefaults.string(forKey: Constant.key),
               let type = SortProfileSortType(rawValue: value) {
                return type
            } else {
                return .none
            }
        }
        set { userDefaults.setValue(newValue.rawValue, forKey: Constant.key) }
    }
}
