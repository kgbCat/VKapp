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
        if let url = selectedData?.sizes.first(where: { ("x").contains($0.type)})?.url{
            print(url)
            photo.kf.setImage(with: URL(string: url))
        }
     
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
