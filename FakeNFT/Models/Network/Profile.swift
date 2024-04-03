//
//  Profile.swift
//  FakeNFT
//
//  Created by Альберт Хайдаров on 28.03.2024.
//

import Foundation

struct Profile: Codable {
    let name: String
    let avatar: String
    let description: String
    let website: String
    let nfts: [String]
    let likes: [String]
    let id: String
}

extension Profile {
    
    func toQueryString() -> String {
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "name", value: name),
            URLQueryItem(name: "avatar", value: avatar),
            URLQueryItem(name: "description", value: description),
            URLQueryItem(name: "website", value: website),
            URLQueryItem(name: "nfts", value: nfts.joined(separator: ",")),
            URLQueryItem(name: "likes", value: likes.joined(separator: ",")),
            URLQueryItem(name: "id", value: id)
        ]
        guard let query = components.percentEncodedQuery else {
            return ""
        }
        return query
    }
    
    
    
    
    
    
    
    
    func getQueryString() -> String {
        
        let parameters = [
            "name": name,
            "avatar": avatar,
            "description": description,
            "website": website,
            "nfts": nfts.joined(separator: ","),
            "likes": likes.joined(separator: ","),
            "id": id
        ]
        
        var parametersString = ""
        
        for (key, value) in parameters {
            if !parametersString.isEmpty {
                parametersString += "&"
            }
            
            parametersString += "\(key)=\(value)"
        }
        return parametersString
    }
    
   
}
