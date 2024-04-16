//
//  NftServiceStub.swift
//  FakeNFTTests
//
//  Created by MAKOVEY Vladislav on 05.04.2024.
//

@testable import FakeNFT
import Foundation

final class NftServiceStub: INftService {
    enum State {
        case success, failure
    }

    let state: State

    private var fakeResult: Nft {
        .init(
            id: "1",
            createdAt: "2024-02-02",
            name: "Fake name",
            images: ["https:\\image.ru"],
            description: "Fake description",
            author: "Fake author",
            price: 50.0,
            rating: 4
        )
    }

    init(state: State = .success) {
        self.state = state
    }

    func loadNft(id: String, completion: @escaping FakeNFT.NftCompletion) {
        switch state {
        case .success:
            completion(fakeResult)
        case .failure:
            completion(nil)
        }
    }
}
