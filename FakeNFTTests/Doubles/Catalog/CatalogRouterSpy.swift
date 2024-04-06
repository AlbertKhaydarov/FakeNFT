//
//  CatalogRouterSpy.swift
//  FakeNFTTests
//
//  Created by MAKOVEY Vladislav on 05.04.2024.
//

@testable import FakeNFT
import Foundation

// swiftlint:disable identifier_name
final class CatalogRouterSpy: ICatalogRouter {

    var invokedOpenCollectionScreen = false
    var invokedOpenCollectionScreenCount = 0
    var invokedOpenCollectionScreenParameters: (item: CatalogItem, Void)?
    var invokedOpenCollectionScreenParametersList = [(item: CatalogItem, Void)]()

    func openCollectionScreen(with item: CatalogItem) {
        invokedOpenCollectionScreen = true
        invokedOpenCollectionScreenCount += 1
        invokedOpenCollectionScreenParameters = (item, ())
        invokedOpenCollectionScreenParametersList.append((item, ()))
    }
}
