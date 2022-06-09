//
//  Items.swift
//  VKapp
//
//  Created by Anna Delova on 7/23/21.
//

import Foundation

struct Items: Codable {
    static func < (lhs: Items, rhs: Items) -> Bool {
        return lhs.source_id < rhs.source_id
    }

    static func == (lhs: Items, rhs: Items) -> Bool {
        return lhs.source_id == rhs.source_id
    }
    
    let source_id: Int
    let text:String?
    let attachments: [Attachments]?
    let comments: Comments?
    let likes: Likes?
    let reposts: Reposts?

}

