//
//  SearchGroups.swift
//  VKapp
//
//  Created by Anna Delova on 7/6/21.
//

import Foundation
import RealmSwift
import SwiftyJSON


class SearchGroups: Object {
    
    @objc dynamic var groupSearchId: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var photo: String = ""
    override class func primaryKey() -> String? {
        "groupSearchId"
    }

}

extension SearchGroups {
    convenience init(_ json: JSON) {
        self.init()
        self.name = json["name"].stringValue
        self.photo = json["photo_200"].stringValue
        self.groupSearchId = json["id"].intValue
    }
}

