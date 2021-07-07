//
//  PhotoCollectionViewController.swift
//  VKapp
//
//  Created by Anna Delova on 7/6/21.
//

import UIKit

class PhotoCollectionViewController: UICollectionViewController {
    
    private let networkService = NetworkRequests()
    private var photos = [VkPhoto]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var userID: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // "FriendPhoto" Register
         let cellNib = UINib(
             nibName: K.CellId.FriendPhotoCell,
             bundle: nil)
         collectionView.register(cellNib,forCellWithReuseIdentifier: K.CellId.FriendPhotoCell)
        
        if let userID = userID {
            networkService.getPhotos(userID: userID) { [weak self] VkPhotos in
                guard
                    let self = self,
                    let photos = VkPhotos
                else { return }
                self.photos = photos
            }
        }

    }


    // MARK: - Navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         guard let selectedItem = sender as? VkPhoto else { return }
         if segue.identifier ==  K.Segue.showPhoto {
             guard let destinationVC = segue.destination as? PhotoViewController else { return }
             destinationVC.selectedData = selectedItem
     }
 }

 override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

     let selectedItem = photos[indexPath.item]
     self.performSegue(withIdentifier: K.Segue.showPhoto, sender: selectedItem)

//        self.present(desVC, animated: true, completion: nil)
     
             
 }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.CellId.FriendPhotoCell, for: indexPath) as? PhotoCollectionViewCell
            else { return UICollectionViewCell() }
        cell.configure(imageURL: photos[indexPath.row] .sizes.first(where: { ("x").contains($0.type) })?.url ?? "")
    
    return cell
}

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
