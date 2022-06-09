//
//  PhotoCollectionViewController.swift
//  VKapp
//
//  Created by Anna Delova on 7/6/21.
//

import UIKit

class PhotoCollectionViewController: UICollectionViewController {
    
    private let photoService: PhotoService = {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        return appDelegate?.photoService ?? PhotoService()
    }()
    
    private let networkService = NetworkRequests()
    private var photos = [VkPhoto]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var userID: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.title = "Photos"
        navigationController?.navigationBar.prefersLargeTitles = true
        makeRefreshControl()
        getPhotos()
        registerCellNib()
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
        let photo = photos[indexPath.row]
        print(photo)
        let likes = photo.likes.count
        cell.configure(
            imageURL: photo.sizes.first(where: { ("x").contains($0.type) })?.url ?? "",
            likes: likes, photoService: photoService )
    
    return cell
}

    // MARK: UICollectionViewDelegate
    
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
        
    }

}
extension PhotoCollectionViewController {
    private func registerCellNib() {
        let cellNib = UINib(
            nibName: K.CellId.FriendPhotoCell,
            bundle: nil)
        collectionView.register(cellNib,forCellWithReuseIdentifier: K.CellId.FriendPhotoCell)
    }
    private func makeRefreshControl(){
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    @objc private func refresh() {
        getPhotos()
    }
    private func getPhotos(){
        if let userID = userID {
            networkService.getPhotos(userID: userID) { [weak self] VkPhotos in
                self?.collectionView.refreshControl?.tintColor = .white
                self?.collectionView.refreshControl?.endRefreshing()
                guard
                    let self = self,
                    let photos = VkPhotos
                else { return }
                self.photos = photos
            }
        }
    }

}
