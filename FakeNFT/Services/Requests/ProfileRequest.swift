//
//  ProfileRequest.swift
//  FakeNFT
//
//  Created by MAKOVEY Vladislav on 27.03.2024.
//

import Foundation

struct GetProfileRequest: NetworkRequest {
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/profile/1")
    }
}

struct SaveProfileRequest: NetworkRequest {
    let infoRequestDto: ProfileInfoRequest

    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/profile/1")
    }

    var httpMethod: HttpMethod { .put }

    var dto: Encodable? { infoRequestDto }
}
