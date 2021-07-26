//
//  PhotoViewController.swift
//  VKapp
//
//  Created by Anna Delova on 7/6/21.
//

import UIKit

class PhotoViewController: UIViewController {
    
    var selectedData: VkPhoto? 
    
    @IBOutlet weak var photo: UIImageView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationItem.backButtonDisplayMode = .minimal
        navigationItem.backBarButtonItem?.tintColor = .white

        if let url = selectedData?.sizes.first(where: { ("x").contains($0.type)})?.url{
            print(url)
            photo.kf.setImage(with: URL(string: url))
        }
     
    }


}
