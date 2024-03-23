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
typealias CollectionSnapshot = NSDiffableDataSourceSnapshot<Section, CollectionItem>
typealias CollectionDataSource = UICollectionViewDiffableDataSource<Section, CollectionItem>

protocol ICollectionView: AnyObject {
    func updateCollectionItems(_ items: [CollectionItem])
}

final class CollectionViewController: UIViewController {
    enum Constant {
        static let baseInset: CGFloat = 16
        static let extraInset: CGFloat = 24

        static let maxSizeOfText: CGFloat = 340
        static let coverSize: CGFloat = 310
    }

    // MARK: - Properties

    private let presenter: any ICollectionPresenter
    private let layoutProvider: any ILayoutProvider

    private var collectionItems = [CollectionItem]() {
        didSet { applySnapshot() }
    }

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

        return imageView.forAutolayout()
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
        label.text = "Автор коллекции:"

        return label.forAutolayout()
    }()

    private lazy var authorLabelLink: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.isUserInteractionEnabled = true

        let tap = UITapGestureRecognizer(target: self, action: #selector(authorLinkDidTap))
        label.addGestureRecognizer(tap)

        return label.forAutolayout()
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0

        return label
    }()

    private lazy var titleWithAuthorStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, authorLabel])
        stack.axis = .vertical
        stack.spacing = 8

        return stack
    }()

    private lazy var middleTextStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleWithAuthorStack, descriptionLabel])
        stack.axis = .vertical

        return stack.forAutolayout()
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutProvider.layout())
        collectionView.register(VerticalNftCell.self)
        collectionView.showsVerticalScrollIndicator = false

        return collectionView.forAutolayout()
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

        middleTextStackView.placedOn(view)
        NSLayoutConstraint.activate([
            middleTextStackView.left.constraint(equalTo: view.left, constant: Constant.baseInset),
            middleTextStackView.top.constraint(equalTo: topImageView.bottom, constant: Constant.baseInset),
            middleTextStackView.right.constraint(equalTo: view.right, constant: -Constant.baseInset),
            middleTextStackView.height.constraint(lessThanOrEqualToConstant: Constant.maxSizeOfText)
        ])

        collectionView.placedOn(view)
        NSLayoutConstraint.activate([
            collectionView.left.constraint(equalTo: view.left, constant: Constant.baseInset),
            collectionView.top.constraint(equalTo: middleTextStackView.bottom, constant: Constant.extraInset),
            collectionView.right.constraint(equalTo: view.right, constant: -Constant.baseInset),
            collectionView.bottom.constraint(equalTo: view.bottom)
        ])
    }

    private func cellProvider(
        collectionView: UICollectionView,
        indexPath: IndexPath,
        item: CollectionItem
    ) -> UICollectionViewCell {
        let cell: VerticalNftCell = collectionView.dequeueReusableCell(indexPath: indexPath)
        let model = VerticalNftCell.Model(
            id: item.id,
            name: item.name,
            imagePath: item.cover,
            rating: Int.random(in: 1...5),
            price: 1.99,
            isFavorite: Bool.random(),
            isInCart: Bool.random()
        )

        cell.configure(model: model)

        return cell
    }

    @objc
    private func authorLinkDidTap() {
        print("Tapped")
    }

    private func applySnapshot() {
        var snapshot = CollectionSnapshot()

        snapshot.appendSections([.main])
        snapshot.appendItems(collectionItems)

        dataSource.apply(snapshot)
    }
}

// MARK: - ICollectionView

extension CollectionViewController: ICollectionView { 
    func updateCollectionItems(_ items: [CollectionItem]) {
        let item = items[0]
        topImageView.kf.indicatorType = .activity
        topImageView.kf.setImage(with: URL(string: item.cover)!)
        authorLabel.text = "Author Label: Unknown"
        descriptionLabel.text = item.description
        titleLabel.text = item.name
        collectionItems = items
    }
}
