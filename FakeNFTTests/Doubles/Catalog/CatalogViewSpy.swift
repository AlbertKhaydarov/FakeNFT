//
//  CatalogViewSpy.swift
//  FakeNFTTests
//
//  Created by MAKOVEY Vladislav on 05.04.2024.
//

@testable import FakeNFT
import Foundation

final class CatalogViewSpy: ICatalogView, ErrorView {

    var invokedUpdateCatalogItems = false
    var invokedUpdateCatalogItemsCount = 0
    var invokedUpdateCatalogItemsParameters: (items: [CatalogItem], Void)?
    var invokedUpdateCatalogItemsParametersList = [(items: [CatalogItem], Void)]()

    func updateCatalogItems(_ items: [CatalogItem]) {
        invokedUpdateCatalogItems = true
        invokedUpdateCatalogItemsCount += 1
        invokedUpdateCatalogItemsParameters = (items, ())
        invokedUpdateCatalogItemsParametersList.append((items, ()))
    }

    var invokedShowSortingAlert = false
    var invokedShowSortingAlertCount = 0

    func showSortingAlert() {
        invokedShowSortingAlert = true
        invokedShowSortingAlertCount += 1
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
