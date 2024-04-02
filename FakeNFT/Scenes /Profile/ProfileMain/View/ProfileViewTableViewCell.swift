//
//  ProfileViewTableViewCell.swift
//  FakeNFT
//
//  Created by Альберт Хайдаров on 24.03.2024.
//

import UIKit

class ProfileViewTableViewCell: UITableViewCell, ReuseIdentifying {

    // MARK: - Properties
    private var presenter: ProfilePresenterProtocol?

    private let buttonsTitles: [String] = [.loc.Profile.MyNFTButton.title,
                                           .loc.Profile.FavoriteNFTButton.title,
                                           .loc.Profile.AboutDesignerButton.title]

    private lazy var accessoryImageView: UIImageView = {
        let сhevronImage = UIImage(systemName: "chevron.forward")
        let imageView = UIImageView(image: сhevronImage)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.tintColor = Assets.ypBlack.color
        return imageView
    }()

    private lazy var titleButtonsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .bodyBold
        label.textColor = Assets.ypBlack.color
        return label
    }()

    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .bodyBold
        label.textColor = Assets.ypBlack.color
        return label
    }()

    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.addArrangedSubview(titleButtonsLabel)
        stackView.addArrangedSubview(countLabel)
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.presenter = nil
        contentView.backgroundColor = Assets.ypWhite.color
        setupSubview()
        layoutSetup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private
    private func setupSubview() {
        contentView.addSubview(labelsStackView)
        contentView.addSubview(accessoryImageView)
    }

    private func layoutSetup() {
        NSLayoutConstraint.activate([
            labelsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            labelsStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            accessoryImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            accessoryImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    // MARK: - Public
    func configureCell(indexPath: IndexPath, with presenter: ProfilePresenterProtocol) {
        titleButtonsLabel.text = buttonsTitles[indexPath.row]
        countLabel.text = "(\(presenter.countTitleButtons[indexPath.row]))"
    }
}
