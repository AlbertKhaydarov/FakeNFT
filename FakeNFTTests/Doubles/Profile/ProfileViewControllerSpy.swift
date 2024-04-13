//
//  ProfileViewControllerSpy.swift
//  FakeNFTTests
//
//  Created by Альберт Хайдаров on 08.04.2024.
//

@testable import FakeNFT
import UIKit

final class ProfileViewControllerSpy: ProfileViewProtocol {
    func showLoader() {
    }

    func hideLoader() {
    }

    var invokedUpdateProfile = false
    var invokedUpdateProfileCount = 0
    var invokedUpdateProfileParameters: (profileModel: FakeNFT.ProfileViewModel, Void)?
    var invokedUpdateProfileParametersList = [(profileModel: FakeNFT.ProfileViewModel, Void)]()

    func updateProfileDetails(profileModel: FakeNFT.ProfileViewModel) {
        invokedUpdateProfile = true
        invokedUpdateProfileCount += 1
        invokedUpdateProfileParameters = (profileModel: profileModel, ())
        invokedUpdateProfileParametersList.append((profileModel: profileModel, ()))
    }
}
