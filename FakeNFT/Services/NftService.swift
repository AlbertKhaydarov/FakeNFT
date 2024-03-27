import Foundation

typealias NftCompletion = (Result<Nft, Error>) -> Void

protocol INftService {
    func loadNft(id: String, completion: @escaping NftCompletion)
}

final class NftService: INftService {

    private let networkClient: any NetworkClient
    private let storage: any INftStorage

    init(networkClient: some NetworkClient, storage: some INftStorage) {
        self.storage = storage
        self.networkClient = networkClient
    }

    func loadNft(id: String, completion: @escaping NftCompletion) {
        if let nft = storage.getNft(with: id) {
            completion(.success(nft))
            return
        }

        let request = NFTRequest(id: id)
        networkClient.send(request: request, type: Nft.self) { [weak storage] result in
            switch result {
            case .success(let nft):
                storage?.saveNft(nft)
                completion(.success(nft))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
