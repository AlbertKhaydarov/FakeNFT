//
//  UIBlockProgressHUD.swift
//  FakeNFT
//
//  Created by MAKOVEY Vladislav on 25.03.2024.
//

import ProgressHUD
import UIKit

struct UIBlockingProgressHUD {
    private static var window: UIWindow? {
        return UIApplication.shared.windows.first
    }

    static func show() {
        window?.isUserInteractionEnabled = false
        ProgressHUD.show()
    }

    static func dismiss() {
        window?.isUserInteractionEnabled = true
        ProgressHUD.dismiss()
    }
}
