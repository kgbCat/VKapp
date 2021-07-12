//
//  NewsTableViewCell.swift
//  VKapp
//
//  Created by Anna Delova on 7/10/21.
//

import UIKit
import Kingfisher

class NewsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var newsPhoto: UIImageView!
    @IBOutlet weak var newsText: UILabel!
    
    @IBOutlet weak var userPhoto: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var newsDate: UILabel!
    
    @IBAction func likePressed(_ sender: UIButton) {
    }
    @IBAction func commentsPressed(_ sender: UIButton) {
    }
    
    @IBAction func repostsPressed(_ sender: UIButton) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(name: String, userImageUrl: String, newsImageUrl: String, text: String, date: Int) {
        newsText.text = text
        userName.text = name
        newsDate.text = date.description
        newsPhoto.kf.setImage(with: URL(string: newsImageUrl))
        userPhoto.kf.setImage(with: URL(string: userImageUrl))
        

        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
