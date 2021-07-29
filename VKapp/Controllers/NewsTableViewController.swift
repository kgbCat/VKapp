//
//  NewsTableViewController.swift
//  VKapp
//
//  Created by Anna Delova on 7/6/21.
//

import UIKit

class NewsTableViewController: UITableViewController {
    
    private let networkService = NetworkRequests()

    private var items = [Items]() {
        didSet {
            tableView.reloadData()
        }
    }
    private var profiles = [Profiles]() {
        didSet {
            tableView.reloadData()
        }
    }
    var idProfile: [Int] = []
    var idItem: [Int] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        makeRefreshControl()
        registerNib()
        getNews()
        
        for profile in profiles {
            idProfile.append(profile.id)
        }
        for item in items {
            idItem.append(item.source_id)
        }

    }
   
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count + profiles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
  
        if indexPath.row == 0 {
            // register profileCell
            guard let cell = (tableView.dequeueReusableCell(withIdentifier: K.CellId.NewsCellProfile, for: indexPath) as? NewsCellProfile)
            else { return UITableViewCell() }
            let currentProfile = profiles[indexPath.row]
            cell.configure(photo: currentProfile.photo_50, name: currentProfile.fullName, id: currentProfile.id)
            return cell

        }
        else if indexPath.row > 0 {
            if idProfile[indexPath.row] == idItem[indexPath.row] {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: K.CellId.NewsCellItem, for: indexPath) as? NewsCellItem
                else { return UITableViewCell() }
                let currentItemNews = items[indexPath.row]
                let photos = currentItemNews.attachments
                var getPhotoSize = [Sizes]()
                for photo in photos {
                    getPhotoSize = photo?.photo.sizes as! [Sizes]
                }
                var url = ""
                for size in getPhotoSize {

                    if size.type == "x" {
                        url = size.url
                    }
                }
                cell.configure(text: currentItemNews.text, image: url, allComments: currentItemNews.comments.count, allLikes: currentItemNews.likes.count, allReposts: currentItemNews.reposts.count, id: currentItemNews.source_id)
                return cell
            }
            else {
                guard let cell = (tableView.dequeueReusableCell(withIdentifier: K.CellId.NewsCellProfile, for: indexPath) as? NewsCellProfile)
                else { return UITableViewCell() }
                let currentProfile = profiles[indexPath.row]
                cell.configure(photo: currentProfile.photo_50, name: currentProfile.fullName, id: currentProfile.id)
            }
            
        }

        return cell
    }

}
extension NewsTableViewController {
    private func registerNib() {
        // register nib for NewsCellProfile
            let nib1 = UINib(nibName: K.CellId.NewsCellProfile, bundle: nil)
            tableView.register(nib1, forCellReuseIdentifier: K.CellId.NewsCellProfile)
        // register nib for NewsCellItem
            let nib2 = UINib(nibName: K.CellId.NewsCellItem, bundle: nil)
            tableView.register(nib2, forCellReuseIdentifier: K.CellId.NewsCellItem)
    }
    
    private func makeRefreshControl(){
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    @objc private func refresh() {
        getNews()
    }
    
    private func getNews() {
        networkService.getNews { [weak self] Items, Profiles in
            guard
                let self = self,
                let items = Items,
                let profiles = Profiles
            else { return }
            self.items = items
            self.profiles = profiles
        }
    }
}
