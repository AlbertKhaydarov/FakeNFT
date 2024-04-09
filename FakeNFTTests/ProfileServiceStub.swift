//
//  ProfileServiceStub.swift
//  FakeNFTTests
//
//  Created by Альберт Хайдаров on 09.04.2024.
//

@testable import FakeNFT
import Foundation

final class ProfileServiceStub: ProfileServiceProtocol {
    
    enum State {
        case success, failure
    }
   
    let state: State
    
    private var mockProfileData = Profile(name: "name",
                                          avatar: "avatar",
                                          description: "description",
                                          website: "websitewebsite",
                                          nfts: ["1", "2"],
                                          likes: ["1"],
                                          id: "1e07d999-5de3-47b6-bd74-a643c4d395e4")
    
    init(state: State = .success) {
        self.state = state
    }
    
    func loadProfile(completion: @escaping FakeNFT.ProfileCompletion) {
        switch state {
        case .success:
            completion(.success(mockProfileData))
        case .failure:
            let error = NSError(domain: "domain", code: 500, userInfo: [NSLocalizedDescriptionKey: "An error occurred"])
            completion(.failure(error))
        }
    }
    
    var invokedUpdateProfile = false
    var invokedUpdateProfileCount = 0
    var invokedUpdateProfileParameters: (model: FakeNFT.Profile?, Void)?
    var invokedUpdateProfileParametersList = [(model: FakeNFT.Profile?, Void)]()
    
    func uploadProfile(model: FakeNFT.Profile?, completion: @escaping FakeNFT.ProfileCompletion) {
        invokedUpdateProfile = true
        invokedUpdateProfileCount += 1
        invokedUpdateProfileParameters = (model, ())
        invokedUpdateProfileParametersList.append((model, ()))
        
        switch state {
        case .success:
            completion(.success(mockProfileData))
        case .failure:
            let error = NSError(domain: "domain", code: 500, userInfo: [NSLocalizedDescriptionKey: "An error occurred"])
            completion(.failure(error))
        }
    }
}

