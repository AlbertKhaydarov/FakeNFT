import Foundation

struct Nft: Decodable {
    let id: String
    let createdAt: String
    let name: String
    let images: [String]
    let description: String
    let author: String
    let price: Decimal
    let rating: Int
}
