//
//  VkNews.swift
//  VKapp
//
//  Created by Anna Delova on 7/8/21.
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
struct Profiles: Codable {
    let first_name: String
    let last_name: String
    let id: Int
    let photo_50: String
    
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

struct Attachments: Codable {
    let photo: Photo
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.photo = try container.decode(Photo.self, forKey: .photo)
    }
    init() {
        self.photo = Photo()
    }
    
}
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
struct Comments: Codable {
    
    let count: Int
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.count = try container.decode(Int.self, forKey: .count)
    }
    init() {
        self.count = 0
    }
}

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
struct Reposts: Codable {
    let count: Int
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.count = try container.decode(Int.self, forKey: .count)
    }
    init() {
        self.count = 0
    }
}
