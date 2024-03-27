//
//  ProfileFavoriteViewController.swift
//  FakeNFT
//
//  Created by Альберт Хайдаров on 26.03.2024.
//

import UIKit

protocol ProfileFavoriteViewProtocol: AnyObject { }


class ProfileFavoriteViewController: UIViewController {
    
    // MARK: - Properties
    
    private let presenter: any ProfileFavoritePresenterProtocol
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = Assets.ypWhite.color
        tableView.register(ProfileFavoriteTableViewCell.self, forCellReuseIdentifier: "favoritesCellReuseIdentifier")
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    init(presenter: some ProfileFavoritePresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = .loc.MyNFTButton.title
        setupSubview()
        layoutSubviews()
        sortButton()
    }
    
    //MARK: - TODO  in the 3rd part
   @objc private func sortButtonTapped() {
       print(#function)
    }
    
    private func sortButton() {
        let rightButton = UIBarButtonItem(image: Assets.sortImage.image, style: .plain, target: self, action: #selector(sortButtonTapped))
        self.navigationItem.rightBarButtonItem = rightButton
        rightButton.tintColor = Assets.ypBlack.color
    }
    
    private func setupSubview() {
        view.addSubview(tableView)
    }
    
    private func layoutSubviews() {
        let height = presenter.favoritesNFT.count * 140
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
           
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.heightAnchor.constraint(equalToConstant: CGFloat(height))
            
            
            
        ])
    }

}
// MARK: - ProfileEditViewProtocol
//MARK: - TODO in the 2nd part
extension ProfileFavoriteViewController: ProfileFavoriteViewProtocol { }

//MARK: - UITableViewDataSource
extension ProfileFavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoritesCellReuseIdentifier", for: indexPath) as? ProfileFavoriteTableViewCell else {return UITableViewCell()}
        cell.configureCell(indexPath: indexPath, with: presenter)
        return cell
    }
}
//MARK: - UITableViewDelegate
extension ProfileFavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140.0
    }
    }
