//
//  ProfileEditViewController.swift
//  FakeNFT
//
//  Created by Альберт Хайдаров on 25.03.2024.
//

import UIKit

protocol ProfileEditViewProtocol: AnyObject {}

class ProfileEditViewController: UIViewController {

    // MARK: - Constants
    private enum Constants {
        static let verticalInset: CGFloat = 11
        static let horizontalInset: CGFloat = 16
        static let baseCornerRadius: CGFloat = 12
        static let StackViewTopSpacing: CGFloat = 24
        static let imageSize: CGFloat = 70
        static let baseHight: CGFloat = 44
        static let baseSpacing: CGFloat = 8
        static let textFieldWidth: CGFloat = 250
        static let textFieldTopConstraint: CGFloat = 4
    }

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
        label.font = .Caption.small
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
        textField.font = .Body.regular
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
        label.font = .Headline.large
        label.textColor = Assets.ypBlack.color
        label.textAlignment = .left
        label.text = .loc.Profile.UserNamelabel.title
        return label
    }()

    private lazy var userNameTextField: UITextField = {
        let textField = UITextField()
        textField.leftView = UIView(frame: CGRect(x: 0,
                                                  y: 0,
                                                  width: Constants.horizontalInset,
                                                  height: Constants.baseHight))
        textField.leftViewMode = .always
        textField.backgroundColor = Assets.ypLightGrey.color
        textField.layer.cornerRadius = 12
        textField.clipsToBounds = true
        textField.font = .Body.regular
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
        stackView.spacing = Constants.baseSpacing
        stackView.addArrangedSubview(userNamelabel)
        stackView.addArrangedSubview(userNameTextField)
        return stackView
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .Headline.medium
        label.textColor = Assets.ypBlack.color
        label.numberOfLines = 0
        label.textAlignment = .left
        label.text = .loc.Profile.DescriptionLabel.title
        return label
    }()

    private lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = Assets.ypLightGrey.color
        textView.layer.cornerRadius = Constants.baseCornerRadius
        textView.clipsToBounds = true
        textView.textContainerInset = UIEdgeInsets(top: Constants.verticalInset,
                                                   left: Constants.horizontalInset,
                                                   bottom: Constants.verticalInset,
                                                   right: Constants.horizontalInset)
        textView.font = .Body.regular
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
        stackView.spacing = Constants.baseSpacing
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(descriptionTextView)
        return stackView
    }()

    private lazy var websiteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .Headline.medium
        label.textColor = Assets.ypBlack.color
        label.text = .loc.Profile.WebsiteLabel.title
        return label
    }()

    private lazy var websiteTextField: UITextField = {
        let textField = UITextField()
        textField.leftView = UIView(frame: CGRect(x: 0,
                                                  y: 0,
                                                  width: Constants.horizontalInset,
                                                  height: Constants.baseHight))
        textField.leftViewMode = .always
        textField.backgroundColor = Assets.ypLightGrey.color
        textField.layer.cornerRadius = 12
        textField.clipsToBounds = true
        textField.font = .Body.regular
        textField.textColor = Assets.ypBlack.color
        textField.becomeFirstResponder()
        textField.delegate = self
        textField.returnKeyType = .done
        textField.isUserInteractionEnabled = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var websiteStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Constants.baseSpacing
        stackView.addArrangedSubview(websiteLabel)
        return stackView
    }()

    private lazy var commonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Constants.StackViewTopSpacing
        stackView.addArrangedSubview(userNameStackView)
        stackView.addArrangedSubview(descriptionStackView)
        stackView.addArrangedSubview(websiteStackView)
        return stackView
    }()

    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = Assets.closeIcon.image
        let templateImage = image.withRenderingMode(.alwaysTemplate)
        button.setImage(templateImage, for: .normal)
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        button.tintColor = Assets.ypBlack.color
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
    var profileUpdateUserProfileImageTextField: Bool = false
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
        if let profileUpdate {
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
            guard let url = URL(string: profileImageString)
            else { return }
            userProfileImageView.kf.setImage(with: url)
        }
    }

    @objc private func userProfileImageTapped() {
        userProfileImageDownloadLinkTextField.isHidden  = false
    }

    @objc private func closeButtonTapped() {
        guard let profileUpdate = profileUpdate else {return}
        guard let name = userNameTextField.text, !name.isEmpty,
              let avatar = userProfileImageDownloadLinkTextField.text,
              let description = descriptionTextView.text, !description.isEmpty,
              let website =  websiteTextField.text, !website.isEmpty
        else {return}

        let updateName = profileUpdateName ? name : profileUpdate.name
        let updateAvatar = profileUpdateUserProfileImageTextField ? avatar : profileUpdate.userPic
        let updateDescription = profileUpdateDescriptionTextView ? description : profileUpdate.description
        let updateWebsite = profileUpdateWebsiteTextField ? website : profileUpdate.website

        let profileUpdateModel = Profile(name: updateName,
                                         avatar: updateAvatar,
                                         description: updateDescription,
                                         website: updateWebsite,
                                         nfts: profileUpdate.nfts,
                                         likes: profileUpdate.likes,
                                         id: profileUpdate.id)

        if profileUpdateName ||
            profileUpdateUserProfileImageTextField ||
            profileUpdateDescriptionTextView ||
            profileUpdateWebsiteTextField {
            showDeleteAlert(with: profileUpdateModel)
        } else {
            dismiss(animated: true)
        }
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
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.horizontalInset),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                  constant: -Constants.horizontalInset),

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
            userProfileImageView.widthAnchor.constraint(equalToConstant: Constants.imageSize),
            userProfileImageView.heightAnchor.constraint(equalToConstant: Constants.imageSize),
            userProfileImageOverlayView.topAnchor.constraint(equalTo: userProfileImageView.topAnchor),
            userProfileImageOverlayView.bottomAnchor.constraint(equalTo: userProfileImageView.bottomAnchor),
            userProfileImageOverlayView.leadingAnchor.constraint(equalTo: userProfileImageView.leadingAnchor),
            userProfileImageOverlayView.trailingAnchor.constraint(equalTo: userProfileImageView.trailingAnchor),
            userProfileImageOverlayView.widthAnchor.constraint(equalToConstant: Constants.imageSize),
            userProfileImageOverlayView.heightAnchor.constraint(equalToConstant: Constants.imageSize),
            editImagelabel.centerXAnchor.constraint(equalTo: userProfileImageView.centerXAnchor),
            editImagelabel.centerYAnchor.constraint(equalTo: userProfileImageView.centerYAnchor),
            editImagelabel.widthAnchor.constraint(equalTo: userProfileImageView.widthAnchor),

            userProfileImageDownloadLinkTextField.topAnchor.constraint(equalTo: userProfileImageView.bottomAnchor,
                                                                       constant: Constants.textFieldTopConstraint),
            userProfileImageDownloadLinkTextField.centerXAnchor.constraint(equalTo:
                                                                            contentViewForScrollView.centerXAnchor),
            userProfileImageDownloadLinkTextField.heightAnchor.constraint(equalToConstant: Constants.baseHight),
            userProfileImageDownloadLinkTextField.widthAnchor.constraint(equalToConstant: Constants.textFieldWidth),
            commonStackView.topAnchor.constraint(equalTo: userProfileImageView.bottomAnchor,
                                                 constant: Constants.StackViewTopSpacing),
            commonStackView.leadingAnchor.constraint(equalTo: contentViewForScrollView.leadingAnchor,
                                                     constant: Constants.horizontalInset),
            commonStackView.trailingAnchor.constraint(equalTo: contentViewForScrollView.trailingAnchor,
                                                      constant: -Constants.horizontalInset),
            userNameStackView.topAnchor.constraint(equalTo: commonStackView.topAnchor),
            userNameTextField.heightAnchor.constraint(equalToConstant: Constants.baseHight),

            websiteTextField.topAnchor.constraint(equalTo: commonStackView.bottomAnchor,
                                                  constant: Constants.baseSpacing),
            websiteTextField.leadingAnchor.constraint(equalTo: contentViewForScrollView.leadingAnchor,
                                                      constant: Constants.horizontalInset),
            websiteTextField.trailingAnchor.constraint(equalTo: contentViewForScrollView.trailingAnchor,
                                                       constant: -Constants.horizontalInset),
            websiteTextField.heightAnchor.constraint(equalToConstant: Constants.baseHight),
            descriptionLabel.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor,
                                                  constant: Constants.StackViewTopSpacing)
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

    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        if textField == userNameTextField {
            profileUpdateName = true
        } else if textField == userProfileImageDownloadLinkTextField {
            profileUpdateUserProfileImageTextField = true
        } else if textField == websiteTextField {
            profileUpdateWebsiteTextField = true
        }
        return true
    }
}

extension ProfileEditViewController {
    private func showDeleteAlert(with profileUpdateModel: Profile) {
        let alertController = UIAlertController(
            title: .loc.Profile.AlertController.title,
            message: nil,
            preferredStyle: .actionSheet
        )
        
        let saveAction = UIAlertAction(
            title: .loc.Profile.AlertControllerSaveAction.title,
            style: .default
        ) { [weak self] _ in
            guard let self else { return }
            delegate?.didCloseViewController(model: profileUpdateModel)
            dismiss(animated: true)
        }
        
        let cancelAction = UIAlertAction(
            title: .loc.Profile.AlertControllerCancelAction.title,
            style: .cancel
        ) { [weak self] _ in
            guard let self else { return }
            dismiss(animated: true)
        }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}
