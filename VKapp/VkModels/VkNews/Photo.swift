//
//  Photo.swift
//  VKapp
//
//  Created by Anna Delova on 7/23/21.
//

import Foundation

struct Photo: Codable {
    let sizes: [Sizes]?
    let owner_id: Int
}
