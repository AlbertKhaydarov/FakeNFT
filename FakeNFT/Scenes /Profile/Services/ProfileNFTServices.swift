//
//  ProfileNFTServices.swift
//  FakeNFT
//
//  Created by Альберт Хайдаров on 29.03.2024.
//

import Foundation

typealias ProfileMyNftCompletion = (Result<ProfileMyNFT, Error>) -> Void

protocol ProfileMyNftServiceProtocol {
    func loadMyNft(id: String, completion: @escaping ProfileMyNftCompletion)
    func loadProfile(completion: @escaping ProfileCompletion)
    func getMyNfts(completion: @escaping ([ProfileMyNFT]) -> Void)
}

final class ProfileMyNftService: ProfileMyNftServiceProtocol {

    private let networkClient: NetworkClient
    private let storage: NftStorage

    private(set) var profileMyNFT: [ProfileMyNFT] = []

    init(networkClient: NetworkClient, storage: NftStorage) {
        self.storage = storage
        self.networkClient = networkClient
    }

    func getMyNfts(completion: @escaping ([ProfileMyNFT]) -> Void) {
        loadNft { [weak self] profileMyNFT in
            guard let self = self else { return }
            completion(profileMyNFT)
        }
    }

    private func loadNft(completion: @escaping ([ProfileMyNFT]) -> Void) {
        loadProfile { [weak self] result in
            switch result {
            case .success(let profile):
                let iDs = profile.nfts
                var nfts: [ProfileMyNFT] = []
//                iDs.compactMap { item in
//                    self?.loadMyNft(id: item) { [weak self] result in
//                        guard let self = self else {return}
//                        switch result {
//                        case .success(let nft):
//                            nfts.append(nft)
//                        case .failure(let error):
//                            assertionFailure("Failed to load Profile \(error)")
//                        }
//                    }
//                }
//                    completion(nfts)
                let group = DispatchGroup()

                            for item in iDs {
                                group.enter()
                                self?.loadMyNft(id: item) { [weak self] result in
                                    defer {
                                        group.leave()
                                    }
                                    guard let self = self else { return }
                                    switch result {
                                    case .success(let nft):
                                        nfts.append(nft)
                                    case .failure(let error):
                                        assertionFailure("Failed to load Profile \(error)")
                                    }
                                }
                            }

                group.notify(queue: .main) {
                    completion(nfts)
                }
            case .failure(let error):
                completion( [])
            }
        }
    }

    func setNFT(nft: ProfileMyNFT) {
        self.profileMyNFT.append(nft)
        print( self.profileMyNFT)
    }

    func loadProfile(completion: @escaping ProfileCompletion) {
        let request = ProfileRequest()
        networkClient.send(request: request, type: Profile.self) { [weak storage] result in
            switch result {
            case .success(let profile):
                storage?.saveProfile(profile)
                completion(.success(profile))
            case .failure(let error):
                assertionFailure("Failed to load Profile \(error)")
                completion(.failure(error))
            }
        }
    }

    func loadMyNft(id: String, completion: @escaping ProfileMyNftCompletion) {

        if let nft = storage.getProfileMyNFT(with: id) {
            completion(.success(nft))
            return
        }
        let request = NFTRequest(id: id)

        networkClient.send(request: request, type: ProfileMyNFT.self) { [weak storage] result in
            switch result {
            case .success(let nft):
                storage?.saveProfileMyNFT(nft)

                completion(.success(nft))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
