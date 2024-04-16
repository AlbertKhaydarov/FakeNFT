//
//  Extension+TextField.swift
//  FakeNFT
//
//  Created by Альберт Хайдаров on 26.03.2024.
//

import UIKit

extension UITextField {
    func setCenteredPlaceholder(_ text: String) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: Assets.ypBlack.color,
            .font: .Body.regular as UIFont,
            .paragraphStyle: paragraphStyle
        ]
        self.attributedPlaceholder = NSAttributedString(string: text, attributes: attributes)
    }
}
