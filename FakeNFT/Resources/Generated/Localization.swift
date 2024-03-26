// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum Localization {
  internal enum Cart {
    /// Корзина
    internal static let title = Localization.tr("Localizable", "Cart.title", fallback: "Корзина")
  }
  internal enum Catalog {
    /// Каталог
    internal static let title = Localization.tr("Localizable", "Catalog.title", fallback: "Каталог")
  }
  internal enum Profile {
    /// Профиль
    internal static let title = Localization.tr("Localizable", "Profile.title", fallback: "Профиль")
  }
  internal enum Statistics {
    /// Статистика
    internal static let title = Localization.tr("Localizable", "Statistics.title", fallback: "Статистика")
  }
  internal enum AboutDesignerButton {
    /// О разработчике
    internal static let title = Localization.tr("Localizable", "aboutDesignerButton.title", fallback: "О разработчике")
  }
  internal enum DescriptionLabel {
    /// Описание
    internal static let title = Localization.tr("Localizable", "descriptionLabel.title", fallback: "Описание")
  }
  internal enum FavoriteNFTButton {
    /// Избранные NFT
    internal static let title = Localization.tr("Localizable", "favoriteNFTButton.title", fallback: "Избранные NFT")
  }
  internal enum MyNFTButton {
    /// Мои NFT
    internal static let title = Localization.tr("Localizable", "myNFTButton.title", fallback: "Мои NFT")
  }
  internal enum UserNamelabel {
    /// Имя
    internal static let title = Localization.tr("Localizable", "userNamelabel.title", fallback: "Имя")
  }
  internal enum UserProfileImageDownload {
    /// Загрузить изображение
    internal static let title = Localization.tr("Localizable", "userProfileImageDownload.title", fallback: "Загрузить изображение")
  }
  internal enum WebsiteLabel {
    /// Сайт
    internal static let title = Localization.tr("Localizable", "websiteLabel.title", fallback: "Сайт")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Localization {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = Bundle.current.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}
