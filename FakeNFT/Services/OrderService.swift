//
//  OrderService.swift
//  FakeNFT
//
//  Created by MAKOVEY Vladislav on 27.03.2024.
//

import Foundation

typealias OrderResult = (Result<Order, Error>) -> Void

protocol IOrderService {
    func loadOrder(completion: @escaping OrderResult)
}

final class OrderService: IOrderService {

    // MARK: - Properties

    private let networkClient: any NetworkClient

    // MARK: - Lifecycle

    init(networkClient: some NetworkClient) {
        self.networkClient = networkClient
    }

    func loadOrder(completion: @escaping OrderResult) {
        let request = OrderRequest()

        networkClient.send(
            request: request,
            type: Order.self,
            completionQueue: .main
        ) {
            switch $0 {
            case let .success(model):
                completion(.success(model))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
