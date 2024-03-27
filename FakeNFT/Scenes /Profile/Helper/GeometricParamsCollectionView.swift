//
//  GeometricParamsCollectionView.swift
//  FakeNFT
//
//  Created by Альберт Хайдаров on 27.03.2024.
//

import Foundation
struct GeometricParams {
    let cellCount: Int
    let leftInset: CGFloat
    let rightInset: CGFloat
    let cellSpacing: CGFloat
    let paddingWidth: CGFloat
    let lineSpacingForSectionAt: CGFloat
    
    init(cellCount: Int, leftInset: CGFloat, rightInset: CGFloat, cellSpacing: CGFloat, lineSpacingForSectionAt: CGFloat) {
        self.cellCount = cellCount
        self.leftInset = leftInset
        self.rightInset = rightInset
        self.cellSpacing = cellSpacing
        self.paddingWidth = leftInset + rightInset + CGFloat(cellCount - 1) * cellSpacing
        self.lineSpacingForSectionAt = lineSpacingForSectionAt
    }
}
