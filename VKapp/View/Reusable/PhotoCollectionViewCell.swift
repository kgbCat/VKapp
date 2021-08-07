//
//  PhotoCollectionViewCell.swift
//  VKapp
//
//  Created by Anna Delova on 7/6/21.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var friendImg: UIImageView!
    
    @IBOutlet weak var likesCount: UILabel!
    @IBOutlet weak var like: UIButton!
  
    var count = 0
    @IBAction func likePressed(_ sender: UIButton) {
        upDateButton(sender)
    }
    
    func configure(imageURL: String, likes: Int, photoService: PhotoService) {
        friendImg.kf.setImage(with: URL(string: imageURL))
        count = likes
        likesCount.text = "\(likes)"
        photoService.getImage(urlString: imageURL) { [weak self] image in
            DispatchQueue.main.async {
                self?.friendImg.image = image
            }
        }
        
    }
    
    fileprivate func upDateButton(_ sender: UIButton) {
        
        if tag == 0 {
            sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            sender.tintColor = .systemRed
            sender.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .selected)
            tag += 1
            count += 1
            likesCount.text = "\(count)"
            
        } else {
               
            sender.setImage(UIImage(systemName: "heart"), for: .normal)
            sender.tintColor = .white
            tag = 0
            count -= 1
            likesCount.text = "\(count)"
        }
    }
    


}
