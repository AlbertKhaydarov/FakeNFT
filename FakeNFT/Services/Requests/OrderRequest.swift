//
//  OrderRequest.swift
//  FakeNFT
//
//  Created by MAKOVEY Vladislav on 27.03.2024.
//

import Foundation

struct GetOrderRequest: NetworkRequest {
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/orders/1")
    }
}

struct SaveOrderRequest: NetworkRequest {
    let nftIds: [String]

    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/orders/1")
    }

    var httpMethod: HttpMethod { .put }

    var dto: Encodable? { nftIds }
}
