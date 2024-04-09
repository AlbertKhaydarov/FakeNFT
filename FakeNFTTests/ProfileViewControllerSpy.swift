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
    
   private var testProfileViewModelData: ProfileViewModel = ProfileViewModel(name: "name",
                                                                             userPic: "userPic",
                                                                             description: "description",
                                                                             website: "website",
                                                                             nfts: ["1", "2"],
                                                                             likes: ["1"],
                                                                             id: "1e07d999-5de3-47b6-bd74-a643c4d395e4")
    
    var invokedUpdateProfileDetails = false
    var invokedUpdateProfileDetailsCount = 0
    var invokedUpdateProfileDetailsParameters: (profileModel: FakeNFT.ProfileViewModel, Void)?
    var invokedUpdateProfileDetailsParametersList = [(profileModel: FakeNFT.ProfileViewModel,  Void)]()
    
    func updateProfileDetails(profileModel: FakeNFT.ProfileViewModel) {
        invokedUpdateProfileDetails = true
        invokedUpdateProfileDetailsCount += 1
        invokedUpdateProfileDetailsParameters = (profileModel: profileModel, ())
        invokedUpdateProfileDetailsParametersList.append((profileModel: profileModel, ()))
    }
}
