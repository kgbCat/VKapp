//
//  Attachments.swift
//  VKapp
//
//  Created by Anna Delova on 7/26/21.
//


import Foundation

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

