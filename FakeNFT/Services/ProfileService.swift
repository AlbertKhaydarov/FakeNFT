//
//  ProfileService.swift
//  FakeNFT
//
//  Created by MAKOVEY Vladislav on 27.03.2024.
//

import Foundation

typealias ProfileInfoResult = (ProfileInfo?) -> Void

protocol IProfileService {
    func loadProfile(completion: @escaping ProfileInfoResult)
    func updateProfile(requestDto: ProfileInfoRequest, completion: @escaping ProfileInfoResult)
}

final class ProfileService: IProfileService {

    // MARK: - Properties

    private let networkClient: any NetworkClient

    // MARK: - Lifecycle

    init(networkClient: some NetworkClient) {
        self.networkClient = networkClient
    }

    func loadProfile(completion: @escaping ProfileInfoResult) {
        let request = GetProfileRequest()

        networkClient.send(
            request: request,
            type: ProfileInfo.self,
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

    func updateProfile(requestDto: ProfileInfoRequest, completion: @escaping ProfileInfoResult) {
        let request = SaveProfileRequest(requestDto: requestDto)

        networkClient.send(
            request: request,
            type: ProfileInfo.self,
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
