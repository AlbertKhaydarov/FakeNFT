//
//  CatalogItemService.swift
//  FakeNFT
//
//  Created by MAKOVEY Vladislav on 25.03.2024.
//

import Foundation

typealias CatalogItemResult = (Result<[CatalogItem], Error>) -> Void

protocol ICatalogItemService {
    func loadCollectionItems(completion: @escaping CatalogItemResult)
}

final class CatalogItemService: ICatalogItemService {

    // MARK: - Properties

    private let networkClient: any NetworkClient

    // MARK: - Lifecycle

    init(networkClient: some NetworkClient) {
        self.networkClient = networkClient
    }

    func loadCollectionItems(completion: @escaping CatalogItemResult) {
        let request = CatalogItemRequest()

        networkClient.send(
            request: request,
            type: [CatalogItem].self,
            completionQueue: .main
        ) {
            switch $0 {
            case let .success(models):
                completion(.success(models))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
