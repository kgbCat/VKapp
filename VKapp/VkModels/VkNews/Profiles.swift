//
//  Profiles.swift
//  VKapp
//
//  Created by Anna Delova on 7/23/21.
//

import Foundation
struct Profiles: Codable, Comparable, Hashable {
    static func < (lhs: Profiles, rhs: Profiles) -> Bool {
        return lhs.id < rhs.id
    }
    let first_name: String
    let last_name: String
    let id: Int
    let photo_50: String
    var fullName: String { "\(first_name) \(last_name)" }
}
