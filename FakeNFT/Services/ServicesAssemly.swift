final class ServicesAssembly {

    private let networkClient: NetworkClient
    private let nftStorage: NftStorage

    init(
        networkClient: NetworkClient,
        nftStorage: NftStorage
    ) {
        self.networkClient = networkClient
        self.nftStorage = nftStorage
    }

    var nftService: NftService {
        NftServiceImpl(
            networkClient: networkClient,
            storage: nftStorage
        )
    }

    var profileService: ProfileServiceProtocol {
        ProfileService(
            networkClient: networkClient,
            storage: nftStorage
        )
    }

    var profileMyNFTService: ProfileMyNftServiceProtocol {
        ProfileMyNftService(networkClient: networkClient,
                            storage: nftStorage)
    }

//    var profileUpdateService: ProfileUpdateServiceProtocol {
//        ProfileUpdateService(
//            networkClient: networkClient,
//            storage: nftStorage
//        )
//    }
}
