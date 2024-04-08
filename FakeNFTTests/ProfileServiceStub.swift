//
//  ProfileServiceStub.swift
//  FakeNFTTests
//
//  Created by Альберт Хайдаров on 08.04.2024.
//

@testable import FakeNFT
import Foundation

final class ProfileServiceStub: ProfileServiceProtocol {
    enum State {
        case success, failure
    }
   
    let state: State
    
   private var testProfileData: Profile = Profile(name: "name",
                                                  avatar: "avatar",
                                                  description: "description",
                                                  website: "websitewebsite",
                                                  nfts: ["1", "2"],
                                                  likes: ["1"],
                                                  id: "1e07d999-5de3-47b6-bd74-a643c4d395e4")
    
    init(state: State = .success) {
        self.state = state
    }
    
    func loadProfile(completion: @escaping ProfileCompletion) {
        switch state {
        case .success:
            completion(testProfileData)
        case .failure:
            completion(nil)
        }
    }
    
    var invokedUpdateProfile = false
    var invokedUpdateProfileCount = 0
    var invokedUpdateProfileParameters: (model: Profile, Void)?
    var invokedUpdateProfileParametersList = [(model: : Profile, Void)]()
    
    func updateProfile(model: Profile, completion: @escaping ProfileInfoResult) {
        invokedUpdateProfile = true
        invokedUpdateProfileCount += 1
        invokedUpdateProfileParameters = (model, ())
        invokedUpdateProfileParametersList.append((model, ()))
        
        switch state {
        case .success:
            completion(testProfileData)
        case .failure:
            completion(nil)
        }
    }
}
