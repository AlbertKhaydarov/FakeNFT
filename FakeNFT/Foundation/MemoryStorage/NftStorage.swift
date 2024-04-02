import Foundation

protocol INftStorage: AnyObject {
    func saveNft(_ nft: Nft)
    func getNft(with id: String) -> Nft?

    func saveProfile(_ profile: Profile)
    func getProfile() -> Profile?

    func saveProfileMyNFT(_ myNFT: ProfileMyNFT)
    func getProfileMyNFT(with id: String) -> ProfileMyNFT?
}

// Пример простого класса, который сохраняет данные из сети
final class NftStorage: INftStorage {
    private var storage: [String: Nft] = [:]

    private let syncQueue = DispatchQueue(label: "sync-nft-queue")
    private var storageProfile: Profile?
    private let syncQueueProfile = DispatchQueue(label: "sync-profile-queue")

    private var storageProfileMyNFT: ProfileMyNFT?
    private let syncQueueProfileMyNFT = DispatchQueue(label: "sync-profileProfileMyNFT-queue")

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

    func saveProfileMyNFT(_ myNFT: ProfileMyNFT) {
        syncQueueProfileMyNFT.async { [weak self] in
            self?.storageProfileMyNFT = myNFT
        }
    }

    func getProfileMyNFT(with id: String) -> ProfileMyNFT? {
        syncQueueProfileMyNFT.sync {
            if let storageProfileMyNFT = storageProfileMyNFT {
                return storageProfileMyNFT
            }
            return nil
        }
    }
}
