//
//  PhotoCollectionViewCell.swift
//  VKapp
//
//  Created by Anna Delova on 7/6/21.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var friendImg: UIImageView!
    
    func configure(imageURL: String) {
        friendImg.kf.setImage(with: URL(string: imageURL))
    }


}
