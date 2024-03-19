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

        setupViewControllers()
    }

    // MARK: = Private

    private func setupViewControllers() {
        let profile = prepareViewController(
            ProfileAssembly.assemble(),
            image: .init(systemName: Constant.profileImageName),
            title: "Profile"
        )

        let catalog = prepareViewController(
            CatalogAssembly.assemble(),
            image: .init(systemName: Constant.catalogImageName),
            title: "Catalog"
        )

        let cart = prepareViewController(
            CartAssembly.assemble(),
            image: .init(systemName: Constant.cartImageName),
            title: "Cart"
        )

        let statistics = prepareViewController(
            StatisticsAssembly.assemble(),
            image: .init(systemName: Constant.statisticsImageName),
            title: "Statistics"
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
