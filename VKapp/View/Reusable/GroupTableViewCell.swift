//
//  GroupTableViewCell.swift
//  VKapp
//
//  Created by Anna Delova on 7/6/21.
//

import UIKit

class GroupTableViewCell: UITableViewCell {

    @IBOutlet weak var groupAvatarImg: UIImageView!
    
    @IBOutlet weak var groupName: UILabel!
    
    func configure(name: String, imageURL: String) {
        groupName.text = name
        groupAvatarImg.kf.setImage(with: URL(string: imageURL))
       
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
