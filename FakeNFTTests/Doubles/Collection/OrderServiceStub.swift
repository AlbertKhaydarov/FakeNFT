//
//  OrderServiceStub.swift
//  FakeNFTTests
//
//  Created by MAKOVEY Vladislav on 05.04.2024.
//

@testable import FakeNFT
import Foundation

final class OrderServiceStub: IOrderService {
    enum State {
        case success, failure
    }

    let state: State

    private var fakeResult: Order {
        .init(
            nfts: ["1", "2", "3"],
            id: "1"
        )
    }

    init(state: State = .success) {
        self.state = state
    }

    func loadOrder(completion: @escaping FakeNFT.OrderResult) {
        switch state {
        case .success:
            completion(fakeResult)
        case .failure:
            completion(nil)
        }
    }

    var invokedUpdateOrder = false
    var invokedUpdateOrderCount = 0
    var invokedUpdateOrderParameters: (nftIds: [String], Void)?
    var invokedUpdateOrderParametersList = [(nftIds: [String], Void)]()
    var stubbedUpdateOrderCompletionResult: (Order?, Void)?

    func updateOrder(nftIds: [String], completion: @escaping FakeNFT.OrderResult) {
        invokedUpdateOrder = true
        invokedUpdateOrderCount += 1
        invokedUpdateOrderParameters = (nftIds, ())
        invokedUpdateOrderParametersList.append((nftIds, ()))

        switch state {
        case .success:
            completion(fakeResult)
        case .failure:
            completion(nil)
        }
    }
}
