//
//  CatalogViewController.swift
//  FakeNFT
//
//  Created by MAKOVEY Vladislav on 19.03.2024.
//

import UIKit

protocol ICatalogView: AnyObject { 
    func updateCollectionItems(_ items: [CollectionItem])
}

final class CatalogViewController: UIViewController {
    private enum Constant {
        static let cellHeight: CGFloat = 180

        static let extraInset: CGFloat = 20
        static let baseInset: CGFloat = 16
    }

    // MARK: - Properties

    private let presenter: any ICatalogPresenter
    private var collectionItems = [CollectionItem]()

    // MARK: - UI

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CatalogCell.self)

        return tableView.forAutolayout()
    }()

    // MARK: - Lifecycle

    init(presenter: some ICatalogPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { nil }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        presenter.viewDidLoad()
        setupUI()
    }

    // MARK: - Private

    private func setupUI() {
        tableView.placedOn(view)
        NSLayoutConstraint.activate([
            tableView.top.constraint(equalTo: view.top, constant: 20),
            tableView.left.constraint(equalTo: view.left, constant: 16),
            tableView.right.constraint(equalTo: view.right, constant: -16),
            tableView.bottom.constraint(equalTo: view.bottom, constant: -20)
        ])
    }
}

// MARK: - ICatalogView

extension CatalogViewController: ICatalogView {
    func updateCollectionItems(_ items: [CollectionItem]) {
        collectionItems = items
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension CatalogViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        collectionItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CatalogCell = tableView.dequeueReusableCell()
        let currentItem = collectionItems[indexPath.row]
        cell.configure(model: .init(
            name: currentItem.name,
            nfts: currentItem.nfts,
            cover: currentItem.cover
        ))
        cell.selectionStyle = .none

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constant.cellHeight
    }
}
