import UIKit

extension UIFont {
    enum Headline {
        /// 34 - bold
        static let extraLarge = UIFont.systemFont(ofSize: 34, weight: .bold)
        /// 28 - bold
        static let large = UIFont.systemFont(ofSize: 28, weight: .bold)
        /// 22 - bold
        static let medium = UIFont.systemFont(ofSize: 22, weight: .bold)
        /// 20 - bold
        static let small = UIFont.systemFont(ofSize: 20, weight: .bold)
    }

    enum Body {
        /// 17 - regular
        static var regular = UIFont.systemFont(ofSize: 17, weight: .regular)
        /// 17 - bold
        static var bold = UIFont.systemFont(ofSize: 17, weight: .bold)
    }

    enum Caption {
        /// 15 - regular
        static var large = UIFont.systemFont(ofSize: 15, weight: .regular)
        /// 13 - regular
        static var medium = UIFont.systemFont(ofSize: 13, weight: .regular)
        /// 10 - regular
        static var small = UIFont.systemFont(ofSize: 10, weight: .regular)
    }
}
