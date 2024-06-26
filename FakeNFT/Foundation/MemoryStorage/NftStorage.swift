import Foundation

protocol INftStorage: AnyObject {
    func saveNft(_ nft: Nft)
    func getNft(with id: String) -> Nft?

    func saveProfile(_ profile: Profile)
    func getProfile() -> Profile?

    func saveProfileMyNFTs(_ myNFTs: [Nft])
    func getProfileMyNFTs(with id: String) -> Nft?
}

final class NftStorageImpl: INftStorage {

    private var storage: [String: Nft] = [:]

    private let syncQueue = DispatchQueue(label: "sync-nft-queue")
    private var storageProfile: Profile?
    private let syncQueueProfile = DispatchQueue(label: "sync-profile-queue")

    private var storageProfileMyNFTs: [Nft]?
    private let syncQueueProfileMyNFTs = DispatchQueue(label: "sync-profileProfileMyNFT-queue")

    func saveNft(_ nft: Nft) {
        syncQueue.async { [weak self] in
            self?.storage[nft.id] = nft
        }
    }

    func getNft(with id: String) -> Nft? {
        syncQueue.sync {
            storage[id]
        }
    }

    func saveProfile(_ profile: Profile) {
        syncQueueProfile.async { [weak self] in
            self?.storageProfile = profile
        }
    }

    func getProfile() -> Profile? {
        syncQueueProfile.sync {
            if let storageProfile = storageProfile {
                return storageProfile
            }
            return nil
        }
    }

    func saveProfileMyNFTs(_ myNFTs: [Nft]) {
        syncQueueProfileMyNFTs.async { [weak self] in
            self?.storageProfileMyNFTs = myNFTs
        }
    }

    func getProfileMyNFTs(with id: String) -> Nft? {
        syncQueueProfileMyNFTs.sync {
            if let profileMyNFT = self.storageProfileMyNFTs?.first(where: { $0.id == id }) {
                return profileMyNFT
            }
            return nil
        }
    }
}
