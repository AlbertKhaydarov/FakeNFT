//
//  CollectionViewController.swift
//
//  in: FakeNFT
//  by: MAKOVEY Vladislav
//  on: 22.03.2024
//

import Kingfisher
import UIKit

enum Section { case main }
typealias CollectionSnapshot = NSDiffableDataSourceSnapshot<Section, PersonalizedNft>
typealias CollectionDataSource = UICollectionViewDiffableDataSource<Section, PersonalizedNft>

protocol ICollectionView: AnyObject {
    func updateCollectionInfo(_ item: CollectionItem, profileInfo: ProfileInfo)
    func updateNfts(_ items: [PersonalizedNft])
}

final class CollectionViewController: UIViewController {
    enum Constant {
        static let minInset: CGFloat = 8
        static let baseInset: CGFloat = 16
        static let extraInset: CGFloat = 24

        static let maxSizeOfText: CGFloat = 340
        static let coverSize: CGFloat = 310
    }

    // MARK: - Properties

    private let presenter: any ICollectionPresenter
    private let layoutProvider: any ILayoutProvider

    private var collectionItems = [PersonalizedNft]() {
        didSet { applySnapshot() }
    }

    private var profileLink: String?

    private lazy var dataSource: CollectionDataSource = {
        CollectionDataSource(collectionView: collectionView) { [weak self] collectionView, indexPath, item in
            guard let self else { fatalError("\(CollectionViewController.self) is nil") }
            return self.cellProvider(collectionView: collectionView, indexPath: indexPath, item: item)
        }
    }()

    // MARK: - UI

    private lazy var topImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]

        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .headline3
        label.textColor = .label

        return label
    }()

    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .caption2
        label.text = .loc.Collection.authorLabelTitle
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        return label
    }()

    private lazy var authorLabelLink: UILabel = {
        let label = UILabel()
        label.textColor = Assets.ypBlueUniversal.color
        label.font = .caption2
        label.isUserInteractionEnabled = true
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)

        let tap = UITapGestureRecognizer(target: self, action: #selector(authorLinkDidTap))
        label.addGestureRecognizer(tap)

        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.font = .caption2

        return label
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutProvider.layout())
        collectionView.register(VerticalNftCell.self)
        collectionView.showsVerticalScrollIndicator = false

        return collectionView
    }()

    // MARK: - Lifecycle

    init(
        presenter: some ICollectionPresenter,
        layoutProvider: some ILayoutProvider
    ) {
        self.presenter = presenter
        self.layoutProvider = layoutProvider
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { nil }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        presenter.viewDidLoad()
    }

    // MARK: - Private

    private func setupUI() {
        view.backgroundColor = .systemBackground

        topImageView.placedOn(view)
        NSLayoutConstraint.activate([
            topImageView.left.constraint(equalTo: view.left),
            topImageView.top.constraint(equalTo: view.top),
            topImageView.right.constraint(equalTo: view.right),
            topImageView.height.constraint(equalToConstant: Constant.coverSize)
        ])

        titleLabel.placedOn(view)
        NSLayoutConstraint.activate([
            titleLabel.left.constraint(equalTo: view.left, constant: Constant.baseInset),
            titleLabel.top.constraint(equalTo: topImageView.bottom, constant: Constant.baseInset),
            titleLabel.right.constraint(equalTo: view.right, constant: -Constant.baseInset)
        ])

        authorLabel.placedOn(view)
        NSLayoutConstraint.activate([
            authorLabel.left.constraint(equalTo: view.left, constant: Constant.baseInset),
            authorLabel.top.constraint(equalTo: titleLabel.bottom, constant: Constant.minInset)
        ])

        authorLabelLink.placedOn(view)
        NSLayoutConstraint.activate([
            authorLabelLink.left.constraint(equalTo: authorLabel.right, constant: 4),
            authorLabelLink.top.constraint(equalTo: titleLabel.bottom, constant: Constant.minInset),
            authorLabelLink.right.constraint(equalTo: view.right, constant: -Constant.baseInset)
        ])

        descriptionLabel.placedOn(view)
        NSLayoutConstraint.activate([
            descriptionLabel.left.constraint(equalTo: view.left, constant: Constant.baseInset),
            descriptionLabel.top.constraint(equalTo: authorLabel.bottom, constant: Constant.minInset),
            descriptionLabel.right.constraint(equalTo: view.right, constant: -Constant.baseInset),
            descriptionLabel.height.constraint(lessThanOrEqualToConstant: Constant.maxSizeOfText)
        ])

        collectionView.placedOn(view)
        NSLayoutConstraint.activate([
            collectionView.left.constraint(equalTo: view.left, constant: Constant.baseInset),
            collectionView.top.constraint(equalTo: descriptionLabel.bottom, constant: Constant.extraInset),
            collectionView.right.constraint(equalTo: view.right, constant: -Constant.baseInset),
            collectionView.bottom.constraint(equalTo: view.bottom)
        ])
    }

    private func cellProvider(
        collectionView: UICollectionView,
        indexPath: IndexPath,
        item: PersonalizedNft
    ) -> UICollectionViewCell {
        let cell: VerticalNftCell = collectionView.dequeueReusableCell(indexPath: indexPath)
        let model = VerticalNftCell.Model(
            id: item.id,
            name: item.name,
            imagePath: item.imagePath,
            rating: item.rating,
            price: item.price,
            isFavorite: item.liked,
            isInCart: item.inCart
        )

        cell.configure(model: model)

        return cell
    }

    @objc
    private func authorLinkDidTap() {
        presenter.authorsLinkTapped(with: profileLink)
    }

    private func applySnapshot() {
        var snapshot = CollectionSnapshot()

        snapshot.appendSections([.main])
        snapshot.appendItems(collectionItems)

        dataSource.apply(snapshot)
    }

    private func downloadCover(with imagePath: String) {
        guard let url = URL(string: imagePath) else { return }

        topImageView.kf.indicatorType = .activity
        topImageView.kf.setImage(with: url)
    }
}

// MARK: - ICollectionView

extension CollectionViewController: ICollectionView {
    func updateNfts(_ items: [PersonalizedNft]) {
        collectionItems = items
    }

    func updateCollectionInfo(_ item: CollectionItem, profileInfo: ProfileInfo) {
        downloadCover(with: item.cover)

        profileLink = profileInfo.website
        authorLabelLink.text = profileInfo.name
        descriptionLabel.text = item.description
        titleLabel.text = item.name
    }
}
