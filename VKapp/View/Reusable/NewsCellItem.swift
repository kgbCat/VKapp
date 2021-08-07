//
//  NewsCellItem.swift
//  VKapp
//
//  Created by Anna Delova on 7/18/21.
//

import UIKit
import Kingfisher


class NewsCellItem: UITableViewCell {
    
    
    @IBOutlet weak var newsText: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    
    @IBOutlet weak var comments: UIButton!
    @IBOutlet weak var likes: UIButton!
    @IBOutlet weak var reposts: UIButton!
    
    var iD = 0
    
    
    func configure( text: String, image: String, allComments: Int, allLikes: Int, allReposts: Int, id: Int) {
        
        newsText.text = text
        newsText.adjustsFontSizeToFitWidth = true
        newsImage.kf.setImage(with: URL(string: image))
        comments.setTitle("\(allComments)", for: .normal)
        likes.setTitle("\(allLikes)", for: .normal)
        reposts.setTitle("\(allReposts)", for: .normal)
        likes.titleLabel?.adjustsFontSizeToFitWidth = true
        iD = id


    }
    
}
