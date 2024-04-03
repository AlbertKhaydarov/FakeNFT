//
//  ProfileRequest.swift
//  FakeNFT
//
//  Created by Альберт Хайдаров on 28.03.2024.
//

import Foundation

struct ProfileRequest: NetworkRequest {

    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/profile/1")
    }
}


