//
//  Sizes.swift
//  VKapp
//
//  Created by Anna Delova on 7/23/21.
//

import Foundation
struct Sizes: Codable {
    let url: String
    let type: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.url = try container.decodeIfPresent(String.self, forKey: .url) ?? ""
        self.type = try container.decodeIfPresent(String.self, forKey: .type) ?? ""
    }
    
    init() {
        self.url = ""
        self.type = "m"
    }
}
