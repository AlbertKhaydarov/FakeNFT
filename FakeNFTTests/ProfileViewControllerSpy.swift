//
//  ProfileViewControllerSpy.swift
//  FakeNFTTests
//
//  Created by Альберт Хайдаров on 08.04.2024.
//

@testable import FakeNFT
import UIKit

// swiftlint:disable all
final class ProfileViewControllerSpy: ProfileViewProtocol {

    enum State {
        case success, failure
    }
   
    let state: State
    
   private var testProfileViewModelData: ProfileViewModel = ProfileViewModel(name: "name",
                                                                             userPic: "userPic",
                                                                             description: "description",
                                                                             website: "website",
                                                                             nfts: ["1", "2"],
                                                                             likes: ["1"],
                                                                             id: "1e07d999-5de3-47b6-bd74-a643c4d395e4")
 
    init(state: State = .success) {
        self.state = state
    }
    
    var invokedUpdateProfileDetails= false
    var invokedUpdateProfileDetailsCount = 0
    var invokedUpdateProfileDetailsParameters: (profileModel: ProfileViewModel, Void)?
    var invokedUpdateProfileDetailsParametersList = [(profileModel: ProfileViewModel,  Void)]()
    
    func updateProfileDetails(profileModel: ProfileViewModel) {
        invokedSwitchToProfileEditView = true
        invokedSwitchToProfileEditViewCount += 1
        invokedSwitchToProfileEditViewParameters = (profileModel: profileModel, ())
        invokedSwitchToProfileEditViewParametersList.append((profileModel: profileModel, ()))
        
        switch state {
        case .success:
            completion(testProfileViewModelData)
        case .failure:
            completion(nil)
        }
    }
}
