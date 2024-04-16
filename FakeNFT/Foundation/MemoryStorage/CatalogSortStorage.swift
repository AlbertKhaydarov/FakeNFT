//
//  SortStorage.swift
//  FakeNFT
//
//  Created by MAKOVEY Vladislav on 26.03.2024.
//

import Foundation

enum SortType: String {
    case byNft, byName, none
}

protocol ICatalogSortStorage {
    var chosenSort: SortType { get set }
}

struct CatalogSortStorage: ICatalogSortStorage {
    private enum Constant {
        static let key = "catalogSort"
    }

    // MARK: - Properties

    private let userDefaults = UserDefaults.standard

    var chosenSort: SortType {
        get {
            if let value = userDefaults.string(forKey: Constant.key),
               let type = SortType(rawValue: value) {
                return type
            } else {
                return .none
            }
        }
        set { userDefaults.setValue(newValue.rawValue, forKey: Constant.key) }
    }
}
