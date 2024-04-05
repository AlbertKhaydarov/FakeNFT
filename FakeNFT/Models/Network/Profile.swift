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
            URLQueryItem(name: "nfts", value: nfts.joined(separator: ",")),
            URLQueryItem(name: "likes", value: likes.joined(separator: ",")),
            URLQueryItem(name: "avatar", value: avatar),
            URLQueryItem(name: "name", value: name),
            URLQueryItem(name: "description", value: description),
            URLQueryItem(name: "website", value: website),
            URLQueryItem(name: "id", value: id)
        ]

        let queryItems = components.queryItems?.map { URLQueryItem(name: $0.name,
                                                                   value: $0.value?.addingPercentEncoding(
                                                                    withAllowedCharacters: .urlQueryValueAllowed)) }
        components.queryItems = queryItems
        return components.query ?? ""
    }

    // MARK: - альтернативный вариант
//    func getQueryString() -> String {
//        var queryItems: [String] = []
//        queryItems.append("name=\(name.addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? "")")
//        queryItems.append("avatar=\(avatar.addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? "")")
//        queryItems.append("description=\(description.addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? "")")
//        queryItems.append("website=\(website.addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? "")")
//        queryItems.append("nfts=\(nfts.map { $0.addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? "" }.joined(separator: ","))")
//        queryItems.append("likes=\(likes.map { $0.addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? "" }.joined(separator: ","))")
//        queryItems.append("id=\(id.addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? "")")
//        print(queryItems.joined(separator: "&"))
//
//        return queryItems.joined(separator: "&")
//    }
    }

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: ":&=;+!@#()")
        return allowed
    }()
}

