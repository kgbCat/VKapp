//
//  Profiles.swift
//  VKapp
//
//  Created by Anna Delova on 7/23/21.
//

import Foundation
struct Profiles: Codable {
    let first_name: String
    let last_name: String
    let id: Int
    let photo_50: String
    
    var fullName: String { "\(first_name) \(last_name)" }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.first_name = try container.decodeIfPresent(String.self, forKey: .first_name) ?? ""
        self.last_name = try container.decodeIfPresent(String.self, forKey: .last_name) ?? ""
        self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        self.photo_50 = try container.decodeIfPresent(String.self, forKey: .photo_50) ?? ""
    }
    init() {
        self.first_name = ""
        self.last_name = ""
        self.id = 0
        self.photo_50 = ""
    }
}
