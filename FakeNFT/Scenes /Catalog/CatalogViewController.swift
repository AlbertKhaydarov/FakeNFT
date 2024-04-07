//
//  CatalogViewController.swift
//  FakeNFT
//
//  Created by MAKOVEY Vladislav on 19.03.2024.
//

import ProgressHUD
import UIKit

protocol ICatalogView: AnyObject {
    func updateCatalogItems(_ items: [CatalogItem])
    func showSortingAlert()
    func showLoader()
    func dismissLoader()
}

final class CatalogViewController: UIViewController, ErrorView {
    private enum Constant {
        static let cellHeight: CGFloat = 180

        static let extraInset: CGFloat = 20
        static let baseInset: CGFloat = 16
    }

    // MARK: - Properties

    private let presenter: any ICatalogPresenter
    private var collectionItems = [CatalogItem]()

    // MARK: - UI

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CatalogCell.self)

        return tableView
    }()

    private lazy var sortButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            image: Assets.sortIcon.image,
            style: .plain,
            target: self,
            action: #selector(sortIconTapped)
        )

        button.accessibilityIdentifier = AccessibilityConstant.sortButton
        button.tintColor = .label

        return button
    }()

    private lazy var refreshCatalogControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(pullToRefreshDragged), for: .valueChanged)

        return control
    }()

    // MARK: - Lifecycle

    init(presenter: some ICatalogPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { nil }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        presenter.viewDidLoad()
    }

    // MARK: - Private

    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.accessibilityIdentifier = AccessibilityConstant.catalogScreen

        navigationItem.rightBarButtonItem = sortButton

        tableView.placedOn(view)
        NSLayoutConstraint.activate([
            tableView.top.constraint(equalTo: view.top, constant: Constant.extraInset),
            tableView.left.constraint(equalTo: view.left, constant: Constant.baseInset),
            tableView.right.constraint(equalTo: view.right, constant: -Constant.baseInset),
            tableView.bottom.constraint(equalTo: view.bottom, constant: -Constant.extraInset)
        ])

        tableView.refreshControl = refreshCatalogControl
    }

    @objc
    private func sortIconTapped() {
        presenter.sortButtonTapped()
    }

    @objc
    private func pullToRefreshDragged() {
        presenter.pullToRefreshDragged()
    }
}

// MARK: - ICatalogView

extension CatalogViewController: ICatalogView {
    func showSortingAlert() {
        let alertController = UIAlertController(
            title: .loc.Catalog.alertTitle,
            message: nil,
            preferredStyle: .actionSheet
        )

        let byNameAction = UIAlertAction(
            title: .loc.Catalog.alertAction1Title,
            style: .default,
            handler: { [weak self] _ in
                self?.presenter.sortByNameChosen()
            }
        )
        byNameAction.accessibilityIdentifier = AccessibilityConstant.sortItemByName

        let byQuantityOfNftAction = UIAlertAction(
            title: .loc.Catalog.alertAction2Title,
            style: .default,
            handler: { [weak self] _ in
                self?.presenter.sortByQuantityChosen()
            }
        )
        byQuantityOfNftAction.accessibilityIdentifier = AccessibilityConstant.sortItemByNft

        let cancelAction = UIAlertAction(
            title: .loc.Catalog.alertCloseActionTitle,
            style: .cancel
        )

        alertController.addAction(byNameAction)
        alertController.addAction(byQuantityOfNftAction)
        alertController.addAction(cancelAction)
        alertController.view.accessibilityIdentifier = AccessibilityConstant.sortingAlert
        present(alertController, animated: true)
    }

    func updateCatalogItems(_ items: [CatalogItem]) {
        collectionItems = items
        tableView.reloadData()
    }

    func showLoader() {
        UIBlockingProgressHUD.show()
    }

    func dismissLoader() {
        UIBlockingProgressHUD.dismiss()
        refreshCatalogControl.endRefreshing()
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
            imagePath: currentItem.cover
        ))
        cell.selectionStyle = .none

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constant.cellHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = collectionItems[indexPath.row]
        presenter.cellDidSelected(with: item)
    }
}
