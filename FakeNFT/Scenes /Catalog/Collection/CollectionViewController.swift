//
//  CollectionViewController.swift
//
//  in: FakeNFT
//  by: MAKOVEY Vladislav
//  on: 22.03.2024
//

import Kingfisher
import UIKit

enum Section {
    case main
}

typealias CollectionSnapshot = NSDiffableDataSourceSnapshot<Section, CollectionViewModel>
typealias CollectionDataSource = UICollectionViewDiffableDataSource<Section, CollectionViewModel>

protocol ICollectionView: AnyObject {
    func updateCollectionInfo(_ item: CatalogItem, profileInfo: ProfileInfo)
    func updateNfts(_ items: [CollectionViewModel])

    func showLoader()
    func dismissLoader()
}

final class CollectionViewController: UIViewController, ErrorView {
    private enum Constant {
        static let minInset: CGFloat = 8
        static let baseInset: CGFloat = 16
        static let extraInset: CGFloat = 24

        static let maxSizeOfText: CGFloat = 340
        static let coverSize: CGFloat = 310
    }

    // MARK: - Properties

    private let presenter: any ICollectionPresenter
    private let layoutProvider: any ILayoutProvider

    private var collectionItems = [CollectionViewModel]() {
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
        label.font = .Headline.medium
        label.textColor = .label

        return label
    }()

    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .Caption.medium
        label.text = .loc.Collection.authorLabelTitle
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.isHidden = true

        return label
    }()

    private lazy var authorLabelLink: UILabel = {
        let label = UILabel()
        label.textColor = Assets.ypBlueUniversal.color
        label.font = .Caption.medium
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
        label.font = .Caption.medium

        return label
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutProvider.layout())
        collectionView.register(VerticalNftCell.self)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self

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
        view.accessibilityIdentifier = AccessibilityConstant.collectionScreen

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
        item: CollectionViewModel
    ) -> UICollectionViewCell {
        let cell: VerticalNftCell = collectionView.dequeueReusableCell(indexPath: indexPath)
        let model = VerticalNftCellModel(
            id: item.id,
            name: item.name,
            imagePath: item.imagePath,
            rating: item.rating,
            price: item.price,
            isFavorite: item.liked,
            isInCart: item.inCart
        )

        cell.delegate = self
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
    func updateNfts(_ items: [CollectionViewModel]) {
        collectionItems = items
        authorLabel.isHidden = false
    }

    func updateCollectionInfo(_ item: CatalogItem, profileInfo: ProfileInfo) {
        downloadCover(with: item.cover)

        profileLink = profileInfo.website
        authorLabelLink.text = profileInfo.name
        descriptionLabel.text = item.description
        titleLabel.text = item.name
    }

    func showLoader() {
        UIBlockingProgressHUD.show()
    }

    func dismissLoader() {
        UIBlockingProgressHUD.dismiss()
    }
}

// MARK: - IVerticalNftCellDelegate

extension CollectionViewController: IVerticalNftCellDelegate {
    func favoriteButtonTapped(with id: String, isFavorite: Bool) {
        presenter.favoriteButtonTapped(id: id, state: isFavorite)
    }

    func cartButtonTapped(with id: String, isInCart: Bool) {
        presenter.cartButtonTapped(id: id, state: isInCart)
    }
}

// MARK: - UICollectionViewDelegate

extension CollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectNft(id: collectionItems[indexPath.row].id)
    }
}
