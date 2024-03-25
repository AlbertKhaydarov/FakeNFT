//
//  CatalogItemRequest.swift
//  FakeNFT
//
//  Created by MAKOVEY Vladislav on 25.03.2024.
//

import Foundation

struct CatalogItemRequest: NetworkRequest {
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/collections")

    }
}
