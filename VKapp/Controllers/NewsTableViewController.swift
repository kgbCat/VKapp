//
//  NewsTableViewController.swift
//  VKapp
//
//  Created by Anna Delova on 7/6/21.
//

import UIKit

class NewsTableViewController: UITableViewController {
    
    private let networkService = NetworkRequests()
    private var items = [Items]()
    private var profiles = [Profiles]()

    override func viewDidLoad() {
        super.viewDidLoad()
        makeRefreshControl()
        registerNib()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
    }
    override func viewWillAppear(_ animated: Bool) {
        getNews()
    }
   
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profiles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        guard let cell = tableView.dequeueReusableCell(withIdentifier: K.CellId.NewsCellItem,
                                                       for: indexPath) as? NewsCellItem
        else { return UITableViewCell() }

        let currentProfile = profiles[indexPath.row]
        var imageUrl = ""
        items.forEach { item in
            if item.source_id  == currentProfile.id {
                item.attachments?.forEach({ attachment in
                    if let photo = attachment.photo {
                        photo.sizes?.forEach({ size in
                            if size.type  == "x" {
                                imageUrl = size.url
                            }
                        })
                        cell.configure(
                            avatar: currentProfile.photo_50,
                            profileName: currentProfile.fullName,
                            text: item.text ?? "",
                            image: imageUrl,
                            likes: item.likes?.count ?? 0,
                            comments: item.comments?.count ?? 0,
                            reposts: item.reposts?.count ?? 0
                        )
                    }
                })
            }
        }
        return cell
    }
}

extension NewsTableViewController {
    private func registerNib() {
        let nib = UINib(nibName: K.CellId.NewsCellItem, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: K.CellId.NewsCellItem)
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
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
