//
//  OrderService.swift
//  FakeNFT
//
//  Created by MAKOVEY Vladislav on 27.03.2024.
//

import Foundation

typealias OrderResult = (Order?) -> Void

protocol IOrderService {
    func loadOrder(completion: @escaping OrderResult)
    func updateOrder(nftIds: [String], completion: @escaping OrderResult)
}

final class OrderService: IOrderService {

    // MARK: - Properties

    private let networkClient: any NetworkClient

    // MARK: - Lifecycle

    init(networkClient: some NetworkClient) {
        self.networkClient = networkClient
    }

    func loadOrder(completion: @escaping OrderResult) {
        let request = GetOrderRequest()

        networkClient.send(
            request: request,
            type: Order.self,
            completionQueue: .main
        ) {
            switch $0 {
            case let .success(model):
                completion(model)
            case .failure:
                completion(nil)
            }
        }
    }

    func updateOrder(nftIds: [String], completion: @escaping OrderResult) {
        let request = SaveOrderRequest(nftIds: nftIds)

        networkClient.send(
            request: request,
            type: Order.self,
            completionQueue: .main
        ) {
            switch $0 {
            case let .success(model):
                completion(model)
            case .failure:
                completion(nil)
            }
        }
    }
}
