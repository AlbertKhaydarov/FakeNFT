//
//  ProfileService.swift
//  FakeNFT
//
//  Created by Альберт Хайдаров on 28.03.2024.
//

import Foundation

typealias ProfileCompletion = (Result<Profile, Error>) -> Void

protocol ProfileServiceProtocol {
    func loadProfile(completion: @escaping ProfileCompletion)
    func uploadProfile(model: Profile?, completion: @escaping ProfileCompletion) 
}

final class ProfileService: ProfileServiceProtocol {
    
    private let networkClient: NetworkClient
    private let storage: NftStorage
    
    init(networkClient: NetworkClient, storage: NftStorage) {
        self.storage = storage
        self.networkClient = networkClient
    }
    
    func loadProfile(completion: @escaping ProfileCompletion) {
//        if let profile = storage.getProfile() {
//            completion(.success(profile))
//        }
        let request = ProfileRequest()
        networkClient.send(request: request, type: Profile.self) { [weak storage] result in
            switch result {
            case .success(let profile):
                storage?.saveProfile(profile)
                completion(.success(profile))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func uploadProfile(model: Profile?, completion: @escaping ProfileCompletion) {
        var request = ProfileUpdateRequest(model: model)
        networkClient.send(request: request, type: Profile.self) { [weak storage] result in
            switch result {
            case .success(let profile):
                storage?.saveProfile(profile)
                
                completion(.success(profile))
            case .failure(let error):
                assertionFailure("Failed to upload Profile \(error)")
                completion(.failure(error))
            }
        }
    }
}
