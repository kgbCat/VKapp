//
//  Response.swift
//  VKapp
//
//  Created by Anna Delova on 7/23/21.
//

import Foundation


struct Response: Codable {
    
    let items: [Items]
    let profiles: [Profiles]
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.items = try container.decodeIfPresent([Items].self, forKey: .items) ?? [Items]()
        self.profiles = try container.decodeIfPresent([Profiles].self, forKey: .profiles) ?? [Profiles]()
    }
    init() {
        self.items = [Items]()
        self.profiles = [Profiles]()
    }

}
