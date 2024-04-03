//
//  ProfileUpdateRequest.swift
//  FakeNFT
//
//  Created by Альберт Хайдаров on 03.04.2024.
//

import Foundation

struct ProfileUpdateRequest: NetworkRequest {
    
    var model: Profile?

    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/profile/1")
    }

    var httpMethod: HttpMethod {
        .put }

    var dto: Encodable? { 
        let str =  model?.getQueryString()
        return str
    }
}
