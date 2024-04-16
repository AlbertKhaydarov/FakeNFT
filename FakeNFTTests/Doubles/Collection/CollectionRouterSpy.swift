//
//  CollectionRouterSpy.swift
//  FakeNFTTests
//
//  Created by MAKOVEY Vladislav on 05.04.2024.
//

@testable import FakeNFT
import Foundation

final class CollectionRouterSpy: ICollectionRouter {

    var invokedOpenWebView = false
    var invokedOpenWebViewCount = 0
    var invokedOpenWebViewParameters: (url: URL, Void)?
    var invokedOpenWebViewParametersList = [(url: URL, Void)]()

    func openWebView(with url: URL) {
        invokedOpenWebView = true
        invokedOpenWebViewCount += 1
        invokedOpenWebViewParameters = (url, ())
        invokedOpenWebViewParametersList.append((url, ()))
    }

    var invokedOpenNftDetal = false
    var invokedOpenNftDetalCount = 0
    var invokedOpenNftDetalParameters: (id: String, Void)?
    var invokedOpenNftDetalParametersList = [(id: String, Void)]()

    func openNftDetal(with id: String) {
        invokedOpenNftDetal = true
        invokedOpenNftDetalCount += 1
        invokedOpenNftDetalParameters = (id, ())
        invokedOpenNftDetalParametersList.append((id, ()))
    }
}
