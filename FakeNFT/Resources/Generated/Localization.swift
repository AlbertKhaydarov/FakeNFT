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
    internal enum AboutDesignerButton {
      /// О разработчике
      internal static let title = Localization.tr("Localizable", "Profile.aboutDesignerButton.title", fallback: "О разработчике")
    }
    internal enum Alert {
      /// Сортировка
      internal static let title = Localization.tr("Localizable", "Profile.alert.title", fallback: "Сортировка")
    }
    internal enum AlertAction1 {
      /// По цене
      internal static let title = Localization.tr("Localizable", "Profile.alertAction1.title", fallback: "По цене")
    }
    internal enum AlertAction2 {
      /// По рейтингу
      internal static let title = Localization.tr("Localizable", "Profile.alertAction2.title", fallback: "По рейтингу")
    }
    internal enum AlertAction3 {
      /// По названию
      internal static let title = Localization.tr("Localizable", "Profile.alertAction3.title", fallback: "По названию")
    }
    internal enum AlertCloseAction {
      /// Закрыть
      internal static let title = Localization.tr("Localizable", "Profile.alertCloseAction.title", fallback: "Закрыть")
    }
    internal enum AuthorLabelText {
      /// от
      internal static let title = Localization.tr("Localizable", "Profile.authorLabelText.title", fallback: "от")
    }
    internal enum DescriptionLabel {
      /// Описание
      internal static let title = Localization.tr("Localizable", "Profile.descriptionLabel.title", fallback: "Описание")
    }
    internal enum EditImagelabel {
      /// Сменить фото
      internal static let title = Localization.tr("Localizable", "Profile.editImagelabel.title", fallback: "Сменить фото")
    }
    internal enum FavoriteNFTButton {
      /// Избранные NFT
      internal static let title = Localization.tr("Localizable", "Profile.favoriteNFTButton.title", fallback: "Избранные NFT")
    }
    internal enum MyNFTButton {
      /// Мои NFT
      internal static let title = Localization.tr("Localizable", "Profile.myNFTButton.title", fallback: "Мои NFT")
    }
    internal enum PriceTitleLabel {
      /// Цена
      internal static let title = Localization.tr("Localizable", "Profile.priceTitleLabel.title", fallback: "Цена")
    }
    internal enum StubFavotitesLabel {
      /// У Вас ещё нет избранных NFT
      internal static let title = Localization.tr("Localizable", "Profile.stubFavotitesLabel.title", fallback: "У Вас ещё нет избранных NFT")
    }
    internal enum StubMyNFTLabel {
      /// У Вас ещё нет NFT
      internal static let title = Localization.tr("Localizable", "Profile.stubMyNFTLabel.title", fallback: "У Вас ещё нет NFT")
    }
    internal enum UserNamelabel {
      /// Имя
      internal static let title = Localization.tr("Localizable", "Profile.userNamelabel.title", fallback: "Имя")
    }
    internal enum UserProfileImageDownload {
      /// Загрузить изображение
      internal static let title = Localization.tr("Localizable", "Profile.userProfileImageDownload.title", fallback: "Загрузить изображение")
    }
    internal enum WebsiteLabel {
      /// Сайт
      internal static let title = Localization.tr("Localizable", "Profile.websiteLabel.title", fallback: "Сайт")
    }
  }
  internal enum Statistics {
    /// Статистика
    internal static let title = Localization.tr("Localizable", "Statistics.title", fallback: "Статистика")
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
