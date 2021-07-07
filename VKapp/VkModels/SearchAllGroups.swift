//
//  SearchAllGroups.swift
//  VKapp
//
//  Created by Anna Delova on 7/7/21.
//

import Foundation
import SwiftyJSON

struct SearchAllGroups: Codable {
//    var groupSearchId: Int
    var name: String
    var photo: String
}
extension SearchAllGroups {
    init(_ json: JSON) {
        self.name = json["name"].stringValue
        self.photo = json["photo_100"].stringValue
    }
}
