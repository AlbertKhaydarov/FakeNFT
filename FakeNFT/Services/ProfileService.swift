//
//  ProfileService.swift
//  FakeNFT
//
//  Created by MAKOVEY Vladislav on 27.03.2024.
//

import Foundation

typealias ProfileInfoResult = (Result<ProfileInfo, Error>) -> Void

protocol IProfileService {
    func loadProfile(completion: @escaping ProfileInfoResult)
}

final class ProfileService: IProfileService {

    // MARK: - Properties

    private let networkClient: any NetworkClient

    // MARK: - Lifecycle

    init(networkClient: some NetworkClient) {
        self.networkClient = networkClient
    }

    func loadProfile(completion: @escaping ProfileInfoResult) {
        let request = ProfileRequest()

        networkClient.send(
            request: request,
            type: ProfileInfo.self,
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
