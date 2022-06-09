//
//  K.swift
//  VKapp
//
//  Created by Anna Delova on 7/6/21.
//

import Foundation


struct K {
    struct Segue {
        static let addGroup = "addGroup"
        static let showPhoto = "showPhoto"
        static let login = "login"
        static let showPhotoCollection = "showPhotoCollection"
    }
    
    struct CellId {
        static let FriendsCell = "UserCell"
        static let FriendPhotoCell = "FriendPhoto"
        static let GroupCell = "GroupCell"
        static let NewsCellPhoto = "NewsCellPhoto"
        static let NewsCellItem = "NewsCellItem"
    }
    
    struct NetworkPaths {
        static let getFriends = "friends.get"
        static let getAllPhotos = "photos.getAll"
        static let getGroups = "groups.get"
        static let searchGroups = "groups.search"
    }

}

