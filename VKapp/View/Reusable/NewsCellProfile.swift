//
//  NewsCellProfile.swift
//  VKapp
//
//  Created by Anna Delova on 7/18/21.
//

import Foundation
import Kingfisher
import UIKit


class NewsCellProfile: UITableViewCell {
    
    
    @IBOutlet weak var userPhoto: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    var iD = 0
    
    func configure( photo: String, name: String, id: Int) {
        userPhoto.kf.setImage(with: URL(string: photo))
        userName.text = name
        iD = id
    }
   
}

