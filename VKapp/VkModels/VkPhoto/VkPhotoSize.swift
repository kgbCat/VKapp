//
//  VkPhotoSize.swift
//  VKapp
//
//  Created by Anna Delova on 7/23/21.
//

import Foundation
import SwiftyJSON

struct VkPhotoSize: Codable {
//    var height: Int
    var url: String
    var type: String
//    var width: Int
}


extension VkPhotoSize {
    init(_ json: JSON) {
        self.url = json["url"].stringValue
        self.type = json["type"].stringValue
    }
}
