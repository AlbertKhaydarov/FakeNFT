//
//  SortStorageStub.swift
//  FakeNFTTests
//
//  Created by MAKOVEY Vladislav on 05.04.2024.
//

@testable import FakeNFT
import Foundation

final class SortStorageStub: ISortStorage {

    let type: SortType

    init(type: SortType) {
        self.type = type
    }

    var invokedChosenSortSetter = false
    var invokedChosenSortSetterCount = 0
    var invokedChosenSort: SortType?
    var invokedChosenSortList = [SortType]()
    var invokedChosenSortGetter = false
    var invokedChosenSortGetterCount = 0

    var chosenSort: SortType {
        set {
            invokedChosenSortSetter = true
            invokedChosenSortSetterCount += 1
            invokedChosenSort = newValue
            invokedChosenSortList.append(newValue)
        }
        get {
            invokedChosenSortGetter = true
            invokedChosenSortGetterCount += 1
            return type
        }
    }
}
