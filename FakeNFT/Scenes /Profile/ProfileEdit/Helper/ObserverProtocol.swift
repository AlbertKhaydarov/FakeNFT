//
//  ObserverProtocol.swift
//  FakeNFT
//
//  Created by Альберт Хайдаров on 04.04.2024.
//

import Foundation
protocol ObserverProtocol: AnyObject {
    func didCloseViewController(model: Profile)
}
