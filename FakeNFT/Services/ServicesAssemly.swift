final class ServicesAssembly {

    private let networkClient: NetworkClient
    private let nftStorage: INftStorage

    init(
        networkClient: NetworkClient,
        nftStorage: INftStorage
    ) {
        self.networkClient = networkClient
        self.nftStorage = nftStorage
    }

    var nftService: INftService {
        NftService(
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
}
