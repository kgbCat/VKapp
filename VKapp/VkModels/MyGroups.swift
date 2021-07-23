//
//  VkGroups.swift
//  VKapp
//
//  Created by Anna Delova on 7/16/21.
//

import Foundation
import SwiftyJSON

struct MyGroups: Codable {
    var groupId: Int
    var name: String
    var photo: String
}
extension MyGroups {
    init(_ json: JSON) {
        self.name = json["name"].stringValue
        self.photo = json["photo_200"].stringValue
        self.groupId = json["id"].intValue
    }
}
