//
//  Main.swift
//  VKapp
//
//  Created by Anna Delova on 7/23/21.
//

import Foundation

struct Main: Codable {
    let response: Response
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.response = try container.decodeIfPresent(Response.self, forKey: .response) ?? Response()
    }
        
        init() {
            self.response = Response()
        }
}

