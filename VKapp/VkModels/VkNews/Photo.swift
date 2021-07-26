//
//  Photo.swift
//  VKapp
//
//  Created by Anna Delova on 7/23/21.
//

import Foundation

struct Photo: Codable {
    let sizes: [Sizes?]
    let owner_id: Int
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.sizes = try container.decodeIfPresent([Sizes].self, forKey: .sizes) ?? [Sizes]()
        self.owner_id = try container.decodeIfPresent(Int.self, forKey: .owner_id) ?? 0
    }
    init() {
        self.sizes = [Sizes?]()
        self.owner_id = 0
    }
}
