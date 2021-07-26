//
//  Likes.swift
//  VKapp
//
//  Created by Anna Delova on 7/26/21.
//


import Foundation

struct Likes: Codable {
    let count:Int
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.count = try container.decode(Int.self, forKey: .count)
    }
    init() {
        self.count = 0
    }
}

