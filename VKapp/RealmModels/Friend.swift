//
//  Friend.swift
//  VKapp
//
//  Created by Anna Delova on 7/6/21.
//


import Foundation
import RealmSwift
import SwiftyJSON


class Friend: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var userAvatarURL: String = ""
    var fullName: String { "\(firstName) \(lastName)" }
//    var userPhotos = List<Photos>()
    
    override class func primaryKey() -> String? {
        "id"
    }
    
    override class func indexedProperties() -> [String] {
        ["firstName", "lastName"]
    }
}

extension Friend {
    convenience init(_ json: JSON) {
        self.init()
        self.id = json["id"].intValue
        self.firstName = json["first_name"].stringValue
        self.lastName = json["last_name"].stringValue
        self.userAvatarURL = json["photo_200_orig"].stringValue
    }
}
