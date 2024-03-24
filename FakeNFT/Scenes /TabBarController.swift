import UIKit

final class TabBarController: UITabBarController {
    private enum Constant {
        static let profileImageName = "figure.wave"
        static let catalogImageName = "figure.wave"
        static let cartImageName = "figure.wave"
        static let statisticsImageName = "figure.wave"
    }

    // Dependencies

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Assets.ypWhite.color
        setupViewControllers()
    }

    // MARK: = Private

    private func setupViewControllers() {
        let profile = prepareViewController(
            ProfileAssembly.assemble(),
            image: .init(systemName: Constant.profileImageName),
            title: .loc.Profile.title
        )

        let catalog = prepareViewController(
            CatalogAssembly.assemble(),
            image: .init(systemName: Constant.catalogImageName),
            title: .loc.Catalog.title
        )

        let cart = prepareViewController(
            CartAssembly.assemble(),
            image: .init(systemName: Constant.cartImageName),
            title: .loc.Cart.title
        )

        let statistics = prepareViewController(
            StatisticsAssembly.assemble(),
            image: .init(systemName: Constant.statisticsImageName),
            title: .loc.Statistics.title
        )

        viewControllers = [profile, catalog, cart, statistics]
    }

    private func prepareViewController(
        _ viewController: UIViewController,
        image: UIImage?,
        title: String
    ) -> UIViewController {
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.prefersLargeTitles = true
        viewController.title = title
        viewController.tabBarItem.image = image
        return navigationController
    }
}
