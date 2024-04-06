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
    let requestDto: ProfileInfoRequest

    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/profile/1")
    }

    var httpMethod: HttpMethod { .put }

    var data: Data? {
        var dataString = """
        name=\(requestDto.name)
        &description=\(requestDto.description)
        &website=\(requestDto.website)
        &likes=
        """
        if requestDto.likes.isEmpty {
            dataString += "null"
        } else {
            requestDto.likes.forEach {
                dataString += "\($0),"
            }
        }
        return dataString.data(using: .utf8)
    }
}
