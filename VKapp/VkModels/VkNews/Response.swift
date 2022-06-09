//
//  Response.swift
//  VKapp
//
//  Created by Anna Delova on 7/23/21.
//

import Foundation


struct Response: Codable {
    
    let items: [Items]
    let profiles: [Profiles]

}
