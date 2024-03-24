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

extension Nft {
    static func makeMockNft() -> Nft {
        .init(
            id: "1",
            createdAt: "2023-04-20T02:22:27Z",
            name: "April",
            images: ["https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ1oryJHBLe6JqGSLEfDAvFsF5iaBzkkGKvCKDCOSqZwQ&s"],
            description: "A 3D model of a mythical creature.",
            author: "2",
            price: 2.99,
            rating: 4
        )
    }
}
