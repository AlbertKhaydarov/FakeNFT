//
//  ProfileUpdateService.swift
//  FakeNFT
//
//  Created by Альберт Хайдаров on 29.03.2024.
//

import Foundation
//
//protocol ProfileUpdateServiceProtocol {
////   func uploadProfile(completion: @escaping Profile)
//}
//
//final class ProfileUpdateService: ProfileUpdateServiceProtocol {
//    
//    private let networkClient: NetworkClient
//    private let storage: NftStorage
//
//    init(networkClient: NetworkClient, storage: NftStorage) {
//        self.storage = storage
//        self.networkClient = networkClient
//    }
//
//    func uploadProfile(model: Profile, completion: @escaping ProfileCompletion) {
//        let request = ProfileRequest()
//       
//        networkClient.send(request: request, type: Profile.self) { [weak storage] result in
//            switch result {
//            case .success(let profile):
//                storage?.saveProfile(profile)
//
//                completion(.success(profile))
//            case .failure(let error):
//                assertionFailure("Failed to load Profile \(error)")
//                completion(.failure(error))
//            }
//        }
//    }
//    
//    
//    
//}
