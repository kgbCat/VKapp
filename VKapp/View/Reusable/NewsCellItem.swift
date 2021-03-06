//
//  NewsCellItem.swift
//  VKapp
//
//  Created by Anna Delova on 7/18/21.
//

import UIKit
import Kingfisher


class NewsCellItem: UITableViewCell {
    
    
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var avatarImage: UserAvatarImg!
    @IBOutlet weak var newsText: UILabel!

    @IBOutlet weak var newsImage: UIImageView!
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var repostButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    
    
    func configure( avatar: String, profileName: String, text: String, image: String, likes: Int, comments: Int, reposts: Int) {

        avatarImage.kf.setImage(with: URL(string: avatar))
        profileNameLabel.text = profileName
        newsText.text = text
        newsImage.kf.setImage(with: URL(string: image))

        likeButton = setLikeButton(likes: likes)
        commentButton = setCommentButton(comments: comments)
        repostButton = setRepostButton(reposts: reposts)

    }

    func setLikeButton(likes: Int) -> UIButton {

        if likes == 0 {
            likeButton.tintColor = .white
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        } else {
            likeButton.tintColor = .systemRed
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
        likeButton.setTitle("\(likes)", for: .normal)
        likeButton.setTitleColor(.white, for: .normal)
        likeButton.titleLabel?.font = UIFont(name: "System", size: 8)


        return likeButton
    }
    func setCommentButton(comments: Int) -> UIButton {
        if comments == 0 {
            commentButton.setImage(UIImage(systemName: "bubble.right"), for: .normal)
            commentButton.tintColor = .white
        } else {
            commentButton.tintColor = .white
            commentButton.setImage(UIImage(systemName: "bubble.right.fill"), for: .normal)
        }
        commentButton.setTitle("\(comments)", for: .normal)
        commentButton.setTitleColor(.white, for: .normal)
        commentButton.titleLabel?.font = UIFont(name: "System", size: 8)
       
        return commentButton
    }
    func setRepostButton(reposts: Int) -> UIButton {
        if reposts == 0 {
            repostButton.tintColor = .white
            repostButton.setImage(UIImage(systemName: "arrowshape.turn.up.left"), for: .normal)
        } else {
            repostButton.tintColor = .white
            repostButton.setImage(UIImage(systemName: "arrowshape.turn.up.left.fill"), for: .normal)
        }
        repostButton.setTitle("\(reposts)", for: .normal)
        repostButton.setTitleColor(.white, for: .normal)
        repostButton.titleLabel?.font = UIFont(name: "System", size: 8)

        return repostButton
    }
}
