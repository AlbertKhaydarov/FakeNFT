//
//  CatalogItemServiceStub.swift
//  FakeNFTTests
//
//  Created by MAKOVEY Vladislav on 05.04.2024.
//

@testable import FakeNFT
import Foundation

final class CatalogItemServiceStub: ICatalogItemService {
    enum State {
        case success, failure
    }

    enum StubError: Error {
        case error
    }

    let state: State

    init(state: State = .success) {
        self.state = state
    }

    func loadCollectionItems(completion: @escaping FakeNFT.CatalogItemResult) {
        switch state {
        case .success:
            completion(.success(.init([])))
        case .failure:
            completion(.failure(StubError.error))
        }

    }
}
