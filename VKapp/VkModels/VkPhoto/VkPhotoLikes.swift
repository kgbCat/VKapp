//
//  VkPhotos.swift
//  VKapp
//
//  Created by Anna Delova on 7/6/21.
//

import Foundation
import SwiftyJSON



struct VkPhotoLikes: Codable {
    let count: Int
    
    init(_ json: JSON) {
        self.count = json["count"].intValue
    }
}
