//
//  ProfileEditViewController.swift
//  FakeNFT
//
//  Created by Альберт Хайдаров on 25.03.2024.
//

import UIKit

protocol ProfileEditViewProtocol: AnyObject { }

class ProfileEditViewController: UIViewController {
    
    // MARK: - Properties
    private let presenter: any ProfileEditPresenterProtocol

    private lazy var userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Assets.editPic.image
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(userProfileImageTapped))
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFit
        imageView.addGestureRecognizer(tapGesture)
        return imageView
    }()

    private lazy var userProfileImageDownloadLinkTextField: UITextField = {
        let textField = UITextField()
        textField.isHidden = true
        textField.backgroundColor = .clear
        textField.font = .bodyRegular
        textField.textColor = Assets.ypBlack.color
        let placeholder: String = .loc.UserProfileImageDownload.title
        textField.setCenteredPlaceholder(placeholder)
        textField.becomeFirstResponder()
        textField.returnKeyType = .done
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var userProfileImageStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.addArrangedSubview(userProfileImageView)
        stackView.addArrangedSubview(userProfileImageDownloadLinkTextField)
        return stackView
    }()
    
    private lazy var userNamelabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .headline3
        label.textColor = Assets.ypBlack.color
        label.textAlignment = .left
        label.text = .loc.UserNamelabel.title
        return label
    }()
    
    private lazy var userNameTextField: UITextField = {
        let textField = UITextField()
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 44))
        textField.leftViewMode = .always
        textField.backgroundColor = Assets.ypLightGrey.color
        textField.layer.cornerRadius = 12
        textField.clipsToBounds = true
        textField.font = .bodyRegular
        textField.textColor = Assets.ypBlack.color
        textField.text = presenter.userNameText
        textField.becomeFirstResponder()
        textField.returnKeyType = .done
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var userNameStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.addArrangedSubview(userNamelabel)
        stackView.addArrangedSubview(userNameTextField)
        return stackView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .headline3
        label.textColor = Assets.ypBlack.color
        label.numberOfLines = 0
        label.textAlignment = .left
        label.text = .loc.DescriptionLabel.title
        return label
    }()
    
    private lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = Assets.ypLightGrey.color
        textView.layer.cornerRadius = 12
        textView.clipsToBounds = true
        textView.textContainerInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        textView.font = .bodyRegular
        textView.text = presenter.descriptionText
        textView.textColor = Assets.ypBlack.color
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false
        textView.isEditable = true
    
        textView.delegate = self
        return textView
    }()
    
    private lazy var descriptionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(descriptionTextView)
        return stackView
    }()
    
    private lazy var websiteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .headline3
        label.textColor = Assets.ypBlack.color
        label.text = .loc.WebsiteLabel.title
        return label
    }()

    private lazy var websiteTextField: UITextField = {
        let textField = UITextField()
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 44))
        textField.leftViewMode = .always
        textField.backgroundColor = Assets.ypLightGrey.color
        textField.layer.cornerRadius = 12
        textField.clipsToBounds = true
        textField.font = .bodyRegular
        textField.textColor = Assets.ypBlack.color
        textField.text = presenter.websiteText
        textField.becomeFirstResponder()
        textField.returnKeyType = .done
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var websiteStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.addArrangedSubview(websiteLabel)
        stackView.addArrangedSubview(websiteTextField)
        return stackView
    }()
    
    private lazy var commonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.addArrangedSubview(userNameStackView)
        stackView.addArrangedSubview(descriptionStackView)
        stackView.addArrangedSubview(websiteStackView)
        return stackView
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(Assets.closeIcon.image, for: .normal)
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    init(presenter: some ProfileEditPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = nil
        view.backgroundColor = Assets.ypWhite.color
        presenter.viewDidLoad()
        setupSubview()
        layoutSubviews()
        navigationController?.navigationBar.prefersLargeTitles = false
  
    }
    
    @objc private func userProfileImageTapped() {
        userProfileImageDownloadLinkTextField.isHidden  = false
    }
    
   @objc private func closeButtonTapped() {
        dismiss(animated: true)
    }
    
    private func setupSubview() {
        view.addSubview(closeButton)
        view.addSubview(userProfileImageStackView)
        view.addSubview(commonStackView)
        
        userProfileImageView.layer.cornerRadius = userProfileImageView.bounds.size.width / 2
        userProfileImageView.layer.masksToBounds = true
    }
    
    private func layoutSubviews() {
        NSLayoutConstraint.activate([
            
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
           
            userProfileImageStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userProfileImageStackView.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 22),
            userProfileImageStackView.widthAnchor.constraint(equalToConstant: 250),
            
            userProfileImageView.centerXAnchor.constraint(equalTo: userProfileImageStackView.centerXAnchor),
            userProfileImageView.widthAnchor.constraint(equalToConstant: 70),
            userProfileImageView.heightAnchor.constraint(equalToConstant: 70),
//            userProfileImageView.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 22),
            
            userProfileImageDownloadLinkTextField.centerXAnchor.constraint(equalTo: userProfileImageStackView.centerXAnchor),
            userProfileImageDownloadLinkTextField.heightAnchor.constraint(equalToConstant: 44),
            userProfileImageDownloadLinkTextField.widthAnchor.constraint(equalToConstant: 250),
            
            commonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            commonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            commonStackView.topAnchor.constraint(equalTo: userProfileImageView.bottomAnchor, constant: 24),
            
            userNameStackView.topAnchor.constraint(equalTo: commonStackView.topAnchor),
            userNameTextField.heightAnchor.constraint(equalToConstant: 44),
            
            websiteTextField.heightAnchor.constraint(equalToConstant: 44),
            
            descriptionLabel.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 24),
            
        ])
    }
}
// MARK: - ProfileEditViewProtocol

extension ProfileEditViewController: ProfileEditViewProtocol { }

extension ProfileEditViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: textView.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        textView.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
    }
}
