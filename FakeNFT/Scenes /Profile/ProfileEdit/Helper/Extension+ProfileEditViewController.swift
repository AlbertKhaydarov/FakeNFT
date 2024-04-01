//
//  Extension+ProfileEditViewController.swift
//  FakeNFT
//
//  Created by Альберт Хайдаров on 01.04.2024.
//

import UIKit

// MARK: - ProfileEditViewProtocol
extension ProfileEditViewController: ProfileEditViewProtocol {}

extension ProfileEditViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: textView.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        textView.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
    }
}

// MARK: - UITextFieldDelegate
extension ProfileEditViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let scrollFrame = scrollView.frame
        let textFieldFrame = textField.frame
        let textFieldY = scrollView.convert(textFieldFrame.origin, from: textField).y + textFieldFrame.size.height
        if textFieldY > scrollFrame.size.height {
            let scrollPoint = CGPoint(x: 0, y: textFieldY - scrollFrame.size.height - textFieldFrame.height )
            scrollView.setContentOffset(scrollPoint, animated: true)
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        scrollView.setContentOffset(CGPoint.zero, animated: true)
        return true
    }
}
