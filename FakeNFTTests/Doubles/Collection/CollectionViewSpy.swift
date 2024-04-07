//
//  CollectionViewSpy.swift
//  FakeNFTTests
//
//  Created by MAKOVEY Vladislav on 05.04.2024.
//

@testable import FakeNFT
import Foundation

// swiftlint:disable identifier_name
final class CollectionViewSpy: ICollectionView, ErrorView {

    var invokedUpdateCollectionInfo = false
    var invokedUpdateCollectionInfoCount = 0
    var invokedUpdateCollectionInfoParameters: (item: CatalogItem, profileInfo: ProfileInfo)?
    var invokedUpdateCollectionInfoParametersList = [(item: CatalogItem, profileInfo: ProfileInfo)]()

    func updateCollectionInfo(_ item: CatalogItem, profileInfo: ProfileInfo) {
        invokedUpdateCollectionInfo = true
        invokedUpdateCollectionInfoCount += 1
        invokedUpdateCollectionInfoParameters = (item, profileInfo)
        invokedUpdateCollectionInfoParametersList.append((item, profileInfo))
    }

    var invokedUpdateNfts = false
    var invokedUpdateNftsCount = 0
    var invokedUpdateNftsParameters: (items: [CollectionViewModel], Void)?
    var invokedUpdateNftsParametersList = [(items: [CollectionViewModel], Void)]()

    func updateNfts(_ items: [CollectionViewModel]) {
        invokedUpdateNfts = true
        invokedUpdateNftsCount += 1
        invokedUpdateNftsParameters = (items, ())
        invokedUpdateNftsParametersList.append((items, ()))
    }

    var invokedShowLoader = false
    var invokedShowLoaderCount = 0

    func showLoader() {
        invokedShowLoader = true
        invokedShowLoaderCount += 1
    }

    var invokedDismissLoader = false
    var invokedDismissLoaderCount = 0

    func dismissLoader() {
        invokedDismissLoader = true
        invokedDismissLoaderCount += 1
    }

    var invokedShowError = false
    var invokedShowErrorCount = 0
    var invokedShowErrorParameters: (model: ErrorModel, Void)?
    var invokedShowErrorParametersList = [(model: ErrorModel, Void)]()

    func showError(_ model: ErrorModel) {
        invokedShowError = true
        invokedShowErrorCount += 1
        invokedShowErrorParameters = (model, ())
        invokedShowErrorParametersList.append((model, ()))
    }
}
