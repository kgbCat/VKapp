//
//  Sizes.swift
//  VKapp
//
//  Created by Anna Delova on 7/23/21.
//

import UIKit
struct Sizes: Codable {
    let url: String
    let type: String
    let height: Int
    let width: Int
    var aspectRatio: CGFloat { return CGFloat(height)/CGFloat(width) }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.url = try container.decodeIfPresent(String.self, forKey: .url) ?? ""
        self.type = try container.decodeIfPresent(String.self, forKey: .type) ?? ""
        self.height = try container.decodeIfPresent(Int.self, forKey: .height) ?? 0
        self.width = try container.decodeIfPresent(Int.self, forKey: .width) ?? 0
        
    }
    
    init() {
        self.url = ""
        self.type = ""
        self.width = 0
        self.height = 0
    }
}
