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

    var id = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        makeRefreshControl()
        registerNib()
        getNews()

    }
   
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let currentProfile = profiles[section]
        id = currentProfile.id
        let author = currentProfile.fullName
        let photo = currentProfile.photo_50
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        headerView.backgroundColor = .clear
        let imageView = setImage(imageUrl: photo)
        let label = setLabel(headerView: headerView, name: author)

        headerView.addSubview(label)
        headerView.addSubview(imageView)

        return headerView

    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return profiles.count
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        guard
//            currentItemNews.source_id == id,
            let cell = tableView.dequeueReusableCell(withIdentifier: K.CellId.NewsCellItem, for: indexPath) as? NewsCellItem
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
        let likes = currentItemNews.likes.count
        let comments = currentItemNews.comments.count
        let reposts = currentItemNews.reposts.count
        cell.configure(
            text: currentItemNews.text,
            image: url,
            likes: likes,
            comments: comments,
            reposts: reposts)
        return cell

    }
}

extension NewsTableViewController {
    private func registerNib() {

    // register nib for NewsCellItem
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
        }

    }
}
extension NewsTableViewController {
    // MARK: - SET HEADER
    
    func setLabel(headerView: UIView, name: String) -> UILabel {
        let label = UILabel()
        label.frame = CGRect.init(x: 55, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
        label.text = name
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        return label
    }
    func setImage(imageUrl: String) -> UIImageView {
        let imageView = UIImageView()
        imageView.kf.setImage(with: URL(string:imageUrl ))
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.frame = CGRect(x: 5, y: 5, width: 40, height: 40)
        imageView.layer.cornerRadius = imageView.frame.height / 2
        return imageView
    }
  
}
