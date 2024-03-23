//
//  CollectionLayoutProvider.swift
//  FakeNFT
//
//  Created by MAKOVEY Vladislav on 22.03.2024.
//

import UIKit

struct CollectionLayoutProvider: ILayoutProvider {
    private enum Constant {
        static let sectionSpacing: CGFloat = 8
        static let cellSpacing: CGFloat = 9
        static let estimatedSupplementaryHeight: CGFloat = 18
        static let absoluteItemHeight: CGFloat = 192
    }

    // MARK: - Public

    func layout() -> UICollectionViewCompositionalLayout {
        let section = makeSection()
        return .init(section: section)
    }

    // MARK: - Private

    private func makeSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1/3),
            heightDimension: .estimated(Constant.absoluteItemHeight)
        )

        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(Constant.absoluteItemHeight)
        )

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: item,
            count: 3
        )
        group.interItemSpacing = .fixed(Constant.cellSpacing)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = Constant.sectionSpacing

        return section
    }
}
