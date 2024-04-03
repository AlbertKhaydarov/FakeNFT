//
//  ProfileNFTServices.swift
//  FakeNFT
//
//  Created by Альберт Хайдаров on 29.03.2024.
//

import Foundation

typealias ProfileMyNftCompletion = (Result<ProfileMyNFT, Error>) -> Void
typealias ProfileMyNftsCompletion = (Result<[ProfileMyNFT], Error>) -> Void

protocol ProfileMyNftServiceProtocol {
    func loadNfts(completion: @escaping ProfileMyNftsCompletion)
    func loadFavoritesNfts(completion: @escaping ProfileMyNftsCompletion) 
}

final class ProfileMyNftService: ProfileMyNftServiceProtocol {

    private let networkClient: NetworkClient
    private let storage: NftStorage

    init(networkClient: NetworkClient, storage: NftStorage) {
        self.storage = storage
        self.networkClient = networkClient
    }

    func loadFavoritesNfts(completion: @escaping ProfileMyNftsCompletion) {
        loadProfile { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let profile):
                let iDs = profile.likes
                var likes: [ProfileMyNFT] = []
                let group = DispatchGroup()
                iDs.compactMap { item in
                    group.enter()
                    self.loadMyNft(id: item) { result in
                        defer {
                            group.leave()
                        }
                        switch result {
                        case .success(let nft):
                            likes.append(nft)

                        case .failure(let error):
                            assertionFailure("Failed to load Profile \(error)")
                        }
                    }
                }
                group.notify(queue: .main) {
                    self.storage.saveProfileMyNFTs(likes)
                    completion(.success(likes))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func loadNfts(completion: @escaping ProfileMyNftsCompletion) {
        loadProfile { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let profile):
                let iDs = profile.nfts
                var nfts: [ProfileMyNFT] = []
                let group = DispatchGroup()
                iDs.compactMap { item in
                    group.enter()
                    self.loadMyNft(id: item) { result in
                        defer {
                            group.leave()
                        }
                        switch result {
                        case .success(let nft):
                            nfts.append(nft)

                        case .failure(let error):
                            assertionFailure("Failed to load Profile \(error)")
                        }
                    }
                }
                group.notify(queue: .main) {
                    self.storage.saveProfileMyNFTs(nfts)
                    completion(.success(nfts))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

   private func loadProfile(completion: @escaping ProfileCompletion) {
       if let profile = storage.getProfile() {
           completion(.success(profile))
       }
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

    private func loadMyNft(id: String, completion: @escaping ProfileMyNftCompletion) {

        if let nft = storage.getProfileMyNFTs(with: id) {
            completion(.success(nft))
            return
        }
        let request = NFTRequest(id: id)

        networkClient.send(request: request, type: ProfileMyNFT.self) { [weak storage] result in
            switch result {
            case .success(let nft):
                completion(.success(nft))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
