//
//  ProfileEditViewController.swift
//  FakeNFT
//
//  Created by Альберт Хайдаров on 25.03.2024.
//

import UIKit

protocol ProfileEditViewProtocol: AnyObject {
}

class ProfileEditViewController: UIViewController {

    // MARK: - Properties
    private let presenter: any ProfileEditPresenterProtocol

    private lazy var userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(userProfileImageTapped))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGesture)
        return imageView
    }()

    private lazy var userProfileImageOverlayView: UIView = {
        let overlayView = UIView()
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        overlayView.backgroundColor = Assets.ypBlackUniversal.color.withAlphaComponent(0.5)
        return overlayView
    }()

    private lazy var editImagelabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .caption3
        label.textColor = Assets.ypWhiteUniversal.color
        label.textAlignment = .center
        label.text = .loc.Profile.EditImagelabel.title
        label.numberOfLines = 0
        return label
    }()

    private lazy var userProfileImageDownloadLinkTextField: UITextField = {
        let textField = UITextField()
        textField.isHidden = true
        textField.backgroundColor = .clear
        textField.font = .bodyRegular
        textField.textColor = Assets.ypBlack.color
        let placeholder: String = .loc.Profile.UserProfileImageDownload.title
        textField.setCenteredPlaceholder(placeholder)
        textField.becomeFirstResponder()
        textField.returnKeyType = .done
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        return textField
    }()

    private lazy var userNamelabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .headline3
        label.textColor = Assets.ypBlack.color
        label.textAlignment = .left
        label.text = .loc.Profile.UserNamelabel.title
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
        textField.becomeFirstResponder()
        textField.returnKeyType = .done
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isUserInteractionEnabled = true
        textField.delegate = self
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
        label.text = .loc.Profile.DescriptionLabel.title
        return label
    }()

    private lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = Assets.ypLightGrey.color
        textView.layer.cornerRadius = 12
        textView.clipsToBounds = true
        textView.textContainerInset = UIEdgeInsets(top: 11, left: 16, bottom: 11, right: 16)
        textView.font = .bodyRegular
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
        label.text = .loc.Profile.WebsiteLabel.title
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
        textField.becomeFirstResponder()
        textField.delegate = self
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

    private let contentViewForScrollView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = Assets.ypWhite.color
        return contentView
    }()

    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = Assets.ypWhite.color
        scrollView.isScrollEnabled = true
        return scrollView
    }()

    var profileUpdate: ProfileViewModel?
    var profileUpdateName: Bool = false
    var profileUpdateUserProfileImageDownloadLinkTextField: Bool = false
    var profileUpdateDescriptionTextView: Bool = false
    var profileUpdateWebsiteTextField: Bool = false
  

    init(presenter: some ProfileEditPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { nil }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupSubview()
        layoutSubviews()
        getInitialProfileDetails()
        updateUserPic()
    }
    
    weak var delegate: ObserverProtocol?

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        userProfileImageView.layer.cornerRadius = userProfileImageView.bounds.size.width / 2
        userProfileImageView.layer.masksToBounds = true
    }

    // MARK: - Private
    private func getInitialProfileDetails() {
        profileUpdate = presenter.getProfileViewModel()
        
        if let profileUpdate = profileUpdate {
            userNameTextField.text = profileUpdate.name
            descriptionTextView.text = profileUpdate.description
            websiteTextField.text = profileUpdate.website
        }
        
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
        scrollView.setContentOffset(CGPoint.zero, animated: true)
    }

    private func updateUserPic() {
        if let profileUpdate = profileUpdate {
            userProfileImageView.kf.indicatorType = .activity
            let profileImageString = profileUpdate.userPic
            guard
                let url = URL(string: profileImageString)
            else {
                return
            }
            userProfileImageView.kf.setImage(with: url)
        }
    }
    


    @objc private func userProfileImageTapped() {
        userProfileImageDownloadLinkTextField.isHidden  = false
    }

    @objc private func closeButtonTapped() {
        guard var profileUpdate = profileUpdate else {return}
        guard var name = userNameTextField.text, !name.isEmpty,
              var avatar = userProfileImageDownloadLinkTextField.text,
              var description = descriptionTextView.text, !description.isEmpty,
              var website =  websiteTextField.text, !website.isEmpty
        else {return}
        
        let updateName = profileUpdateName ? name : profileUpdate.name
        let updateAvatar = profileUpdateUserProfileImageDownloadLinkTextField ? avatar : profileUpdate.userPic
        let updateDescription = profileUpdateDescriptionTextView ? description : profileUpdate.description
        let updateWebsite = profileUpdateWebsiteTextField ? website : profileUpdate.website
        
        let profileUpdateModel = Profile(name: name,
                                         avatar: updateAvatar,
                                         description: updateDescription,
                                         website: updateWebsite,
                                         nfts: profileUpdate.nfts,
                                         likes: profileUpdate.likes,
                                         id: profileUpdate.id)
        
        delegate?.didCloseViewController(model: profileUpdateModel)
        dismiss(animated: true)
    }

    private func setupView() {
        self.title = nil
        presenter.viewDidLoad()
        view.backgroundColor = Assets.ypWhite.color
        navigationController?.navigationBar.prefersLargeTitles = false
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    private func setupSubview() {
        view.addSubview(closeButton)
        view.addSubview(scrollView)
        scrollView.addSubview(contentViewForScrollView)
        contentViewForScrollView.addSubview(commonStackView)
        contentViewForScrollView.addSubview(websiteTextField)
        contentViewForScrollView.addSubview(userProfileImageView)
        contentViewForScrollView.addSubview(userProfileImageDownloadLinkTextField)
        userProfileImageView.addSubview(userProfileImageOverlayView)
        userProfileImageView.addSubview(editImagelabel)
    }

    private func layoutSubviews() {
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            scrollView.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 22),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            contentViewForScrollView.widthAnchor.constraint(equalToConstant: view.bounds.width),
            contentViewForScrollView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentViewForScrollView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentViewForScrollView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentViewForScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            userProfileImageView.centerXAnchor.constraint(equalTo: contentViewForScrollView.centerXAnchor),
            userProfileImageView.topAnchor.constraint(equalTo: contentViewForScrollView.topAnchor),
            userProfileImageView.widthAnchor.constraint(equalToConstant: 70),
            userProfileImageView.heightAnchor.constraint(equalToConstant: 70),

            userProfileImageOverlayView.topAnchor.constraint(equalTo: userProfileImageView.topAnchor),
            userProfileImageOverlayView.bottomAnchor.constraint(equalTo: userProfileImageView.bottomAnchor),
            userProfileImageOverlayView.leadingAnchor.constraint(equalTo: userProfileImageView.leadingAnchor),
            userProfileImageOverlayView.trailingAnchor.constraint(equalTo: userProfileImageView.trailingAnchor),
            userProfileImageOverlayView.widthAnchor.constraint(equalToConstant: 70),
            userProfileImageOverlayView.heightAnchor.constraint(equalToConstant: 70),

            editImagelabel.centerXAnchor.constraint(equalTo: userProfileImageView.centerXAnchor),
            editImagelabel.centerYAnchor.constraint(equalTo: userProfileImageView.centerYAnchor),
            editImagelabel.widthAnchor.constraint(equalTo: userProfileImageView.widthAnchor),

            userProfileImageDownloadLinkTextField.topAnchor.constraint(equalTo: userProfileImageView.bottomAnchor,
                                                                       constant: 4),
            userProfileImageDownloadLinkTextField.centerXAnchor.constraint(equalTo:
                                                                            contentViewForScrollView.centerXAnchor),
            userProfileImageDownloadLinkTextField.heightAnchor.constraint(equalToConstant: 44),
            userProfileImageDownloadLinkTextField.widthAnchor.constraint(equalToConstant: 250),

            commonStackView.topAnchor.constraint(equalTo: userProfileImageView.bottomAnchor, constant: 24),
            commonStackView.leadingAnchor.constraint(equalTo: contentViewForScrollView.leadingAnchor, constant: 16),
            commonStackView.trailingAnchor.constraint(equalTo: contentViewForScrollView.trailingAnchor, constant: -16),

            userNameStackView.topAnchor.constraint(equalTo: commonStackView.topAnchor),
            userNameTextField.heightAnchor.constraint(equalToConstant: 44),

            websiteTextField.topAnchor.constraint(equalTo: commonStackView.bottomAnchor, constant: 8),
            websiteTextField.leadingAnchor.constraint(equalTo: contentViewForScrollView.leadingAnchor, constant: 16),
            websiteTextField.trailingAnchor.constraint(equalTo: contentViewForScrollView.trailingAnchor, constant: -16),
            websiteTextField.heightAnchor.constraint(equalToConstant: 44),

            descriptionLabel.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 24)
        ])
    }
}

// MARK: - ProfileEditViewProtocol
extension ProfileEditViewController: ProfileEditViewProtocol {}

extension ProfileEditViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: textView.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        textView.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
        if textView == descriptionTextView {
            profileUpdateDescriptionTextView = true
        }
    }
}

// MARK: - UITextFieldDelegate
extension ProfileEditViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let scrollFrame = scrollView.frame
        let textFieldFrame = textField.frame
        let textFieldY = scrollView.convert(textFieldFrame.origin, from: textField).y + textFieldFrame.size.height
        if textFieldY > scrollFrame.size.height {
            let scrollPoint = CGPoint(x: 0, y: textFieldY - scrollFrame.size.height - textFieldFrame.height )
            scrollView.setContentOffset(scrollPoint, animated: true)
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        scrollView.setContentOffset(CGPoint.zero, animated: true)
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == userNameTextField {
                profileUpdateName = true
            } else if textField == userProfileImageDownloadLinkTextField {
                profileUpdateUserProfileImageDownloadLinkTextField = true
            } else if textField == websiteTextField {
                profileUpdateWebsiteTextField = true
            }
    }
}

