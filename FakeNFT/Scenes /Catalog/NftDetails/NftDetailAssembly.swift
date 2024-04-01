import UIKit

public final class NftDetailAssembly {
    // MARK: - Public

    static func assemble(with input: NftDetailInput) -> UIViewController {
        let nftService: INftService = NftService(networkClient: DefaultNetworkClient(), storage: NftStorage())

        let presenter = NftDetailPresenterImpl(
            input: input,
            service: nftService
        )
        let viewController = NftDetailViewController(presenter: presenter)

        presenter.view = viewController

        return viewController
    }
}
