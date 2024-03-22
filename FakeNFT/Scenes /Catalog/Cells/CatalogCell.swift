//
//  CatalogCell.swift
//  FakeNFT
//
//  Created by MAKOVEY Vladislav on 22.03.2024.
//

import Kingfisher
import UIKit

final class CatalogCell: UITableViewCell, ReuseIdentifying {
    struct Model {
        let name: String
        let nfts: [Int]
        let cover: String
    }

    private enum Constant {
        static let mainImageViewHeight: CGFloat = 140
        static let baseCornerRadius: CGFloat = 12

        static let minInset: CGFloat = 4
        static let baseInset: CGFloat = 12
    }

    // MARK: - UI

    private lazy var mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = Constant.baseCornerRadius

        return imageView.forAutolayout()
    }()

    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = .bodyBold

        return label.forAutolayout()
    }()

    // MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
    }

    required init?(coder: NSCoder) { nil }

    override func prepareForReuse() {
        super.prepareForReuse()

        mainImageView.kf.cancelDownloadTask()
        mainImageView.image = nil
    }

    func configure(model: Model) {
        label.text = "\(model.name) (\(model.nfts.count))"
        downloadImage(path: model.cover)
    }

    // MARK: - Private

    private func setupUI() {
        mainImageView.placedOn(contentView)
        NSLayoutConstraint.activate([
            mainImageView.left.constraint(equalTo: contentView.left),
            mainImageView.right.constraint(equalTo: contentView.right),
            mainImageView.height.constraint(equalToConstant: Constant.mainImageViewHeight),
        ])

        label.placedOn(contentView)
        NSLayoutConstraint.activate([
            label.left.constraint(equalTo: contentView.left),
            label.top.constraint(equalTo: mainImageView.bottom, constant: Constant.minInset),
            label.bottom.constraint(equalTo: contentView.bottom, constant: -Constant.baseInset)
        ])
    }

    private func downloadImage(path: String) {
        guard let url = URL(string: path) else { return }
        mainImageView.kf.setImage(with: url)
    }
}
