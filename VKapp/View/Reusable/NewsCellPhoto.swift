//
//  NewsCellPhoto.swift
//  VKapp
//
//  Created by Anna Delova on 7/31/21.
//

import UIKit

class NewsCellPhoto: UITableViewCell {

    @IBOutlet weak var newsPhoto: UIImageView!

        func configure( image: String) {
    
            newsPhoto.kf.setImage(with: URL(string: image))
        }
    
}
