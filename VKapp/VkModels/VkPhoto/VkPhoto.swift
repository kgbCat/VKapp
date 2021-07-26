//
//  VkPhoto.swift
//  VKapp
//
//  Created by Anna Delova on 7/23/21.
//

import Foundation
import SwiftyJSON

struct VkPhoto: Codable {
    var sizes: [VkPhotoSize]
    var likes: VkPhotoLikes
    var owner_id: Int
    
}
extension VkPhoto {
    init(_ json: JSON) {
        self.owner_id = json["owner_id"].intValue
        let sizes = json["sizes"].arrayValue
        self.sizes = sizes.map { VkPhotoSize($0) }
//        let like = json["likes"].object
        self.likes = VkPhotoLikes(json["likes"])
    }
    
}
