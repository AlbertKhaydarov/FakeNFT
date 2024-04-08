//
//  ProfileServiceStub.swift
//  FakeNFTTests
//
//  Created by MAKOVEY Vladislav on 05.04.2024.
//

@testable import FakeNFT
import Foundation

final class ProfileServiceStub: IProfileService {
    enum State {
        case success, failure
    }

    let state: State

    private var fakeResult: ProfileInfo {
        .init(
            name: "Fake name",
            avatar: "Fake avatar",
            description: "Fake description",
            website: "Fake website",
            nfts: ["1", "2"],
            likes: ["1"],
            id: UUID().uuidString
        )
    }

    init(state: State = .success) {
        self.state = state
    }

    func loadProfile(completion: @escaping FakeNFT.ProfileInfoResult) {
        switch state {
        case .success:
            completion(fakeResult)
        case .failure:
            completion(nil)
        }
    }

    var invokedUpdateProfile = false
    var invokedUpdateProfileCount = 0
    var invokedUpdateProfileParameters: (requestDto: ProfileInfoRequest, Void)?
    var invokedUpdateProfileParametersList = [(requestDto: ProfileInfoRequest, Void)]()

    func updateProfile(requestDto: FakeNFT.ProfileInfoRequest, completion: @escaping FakeNFT.ProfileInfoResult) {
        invokedUpdateProfile = true
        invokedUpdateProfileCount += 1
        invokedUpdateProfileParameters = (requestDto, ())
        invokedUpdateProfileParametersList.append((requestDto, ()))

        switch state {
        case .success:
            completion(fakeResult)
        case .failure:
            completion(nil)
        }
    }
}
