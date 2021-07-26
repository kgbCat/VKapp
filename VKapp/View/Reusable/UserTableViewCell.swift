//
//  UserTableViewCell.swift
//  VKapp
//
//  Created by Anna Delova on 7/6/21.
//

import UIKit
import Kingfisher

class UserTableViewCell: UITableViewCell {


    @IBOutlet weak var userAvatarImg: UserAvatarImg!
    @IBOutlet weak var userName: UILabel!
    
    
    func configure(name: String, imageURL: String, photoService: PhotoService) {
        userAvatarImg.kf.setImage(with: URL(string: imageURL))
        userName.text = name
        photoService.getImage(urlString: imageURL) { [weak self] image in
            DispatchQueue.main.async {
                self?.userAvatarImg.image = image
            }
        }
        
    }
    
    func animateAvatar() {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 1
        animation.toValue = 0.5
        animation.mass = 1.5
        animation.duration = 0.4
        animation.beginTime = CACurrentMediaTime() + 0.5
        animation.stiffness = 300
        animation.fillMode = CAMediaTimingFillMode.backwards

        self.userAvatarImg.layer.add(animation, forKey: nil)
    }
    override func addGestureRecognizer(_ gestureRecognizer: UIGestureRecognizer) {
        viewTapped()
    }
    @objc func viewTapped() {
        animateAvatar()
    }

    
}
