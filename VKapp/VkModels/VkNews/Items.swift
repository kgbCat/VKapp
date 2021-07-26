//
//  Items.swift
//  VKapp
//
//  Created by Anna Delova on 7/23/21.
//

import Foundation
struct Items: Codable {
    let source_id: Int
    let date: Int
    let text:String
    let attachments: [Attachments?]
    let comments: Comments
    let likes: Likes
    let reposts: Reposts
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.source_id = try container.decodeIfPresent(Int.self, forKey: .source_id) ?? 0
        self.date = try container.decodeIfPresent(Int.self, forKey: .date) ?? 0
        self.text = try container.decodeIfPresent(String.self, forKey: .text) ?? ""
        self.attachments = try container.decodeIfPresent([Attachments].self, forKey: .attachments) ?? [Attachments]()
        self.comments = try container.decodeIfPresent(Comments.self, forKey: .comments) ?? Comments()
        self.likes = try container.decodeIfPresent(Likes.self, forKey: .likes) ?? Likes()
        self.reposts = try container.decodeIfPresent(Reposts.self, forKey: .reposts) ?? Reposts()
    }
    init() {
        self.source_id = 0
        self.date = 0
        self.attachments = [Attachments?]()
        self.comments = Comments()
        self.likes = Likes()
        self.reposts = Reposts()
        self.text = ""
    }
}
