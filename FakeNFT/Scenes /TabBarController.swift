import UIKit

final class TabBarController: UITabBarController {
    private enum Constant {
        static let profileImageIcon = Assets.tabProfileImage.image
        static let catalogImageIcon = Assets.catalogTabIcon.image
        static let cartImageName = "figure.wave"
        static let statisticsImageName = "figure.wave"
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Assets.ypWhite.color

        setupViewControllers()
        setupNavigationAppearance()
    }

    // MARK: = Private

    private func setupViewControllers() {
        let profile = prepareViewController(
            ProfileAssembly.assemble(),
            image: Constant.profileImageIcon,
            title: .loc.Profile.title,
            tag: 0
        )

        let catalog = prepareViewController(
            CatalogAssembly.assemble(),
            image: Constant.catalogImageIcon,
            title: .loc.Catalog.title,
            tag: 1
        )

        let cart = prepareViewController(
            CartAssembly.assemble(),
            image: .init(systemName: Constant.cartImageName),
            title: .loc.Cart.title,
            tag: 2
        )

        let statistics = prepareViewController(
            StatisticsAssembly.assemble(),
            image: .init(systemName: Constant.statisticsImageName),
            title: .loc.Statistics.title,
            tag: 3
        )

        viewControllers = [profile, catalog, cart, statistics]
        selectedIndex = 1
    }

    private func prepareViewController(
        _ viewController: UIViewController,
        image: UIImage?,
        title: String,
        tag: Int
    ) -> UIViewController {
        let navigationController = UINavigationController(rootViewController: viewController)
        let tabBarItem = UITabBarItem(title: title, image: image, tag: tag)
        viewController.tabBarItem = tabBarItem
        return navigationController
    }

    private func setupNavigationAppearance() {
        UINavigationBar.appearance().backIndicatorImage = Assets.backwardIcon.image
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = Assets.backwardIcon.image
        UINavigationBar.appearance().tintColor = Assets.ypBlack.color
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear],
                                                            for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear],
                                                            for: .highlighted)
    }
}
