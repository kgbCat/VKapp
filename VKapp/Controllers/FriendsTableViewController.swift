//
//  FriendsTableViewController.swift
//  VKapp
//
//  Created by Anna Delova on 7/6/21.
//

import UIKit
import RealmSwift

class FriendsTableViewController: UITableViewController, UISearchBarDelegate {
    private let networkService = NetworkRequests()
    private let users = try? RealmService.load(typeOf: Friend.self).filter("firstName != 'DELETED' AND userAvatarURL != 'https://vk.com/images/deactivated_200.png'").sorted(byKeyPath: "firstName")

    private let photoService: PhotoService = {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        return appDelegate?.photoService ?? PhotoService()
    }()
    
    var searchFriends: Results<Friend>?
    
    private var token: NotificationToken?
    private var isLoading = false
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        registerNib()
        makeRefreshControl()
        observeRealm()
        getUsers()
//        configPrefetch()
        navigationController?.title = "Friends"
        navigationController?.navigationBar.prefersLargeTitles = true
        searchBar.delegate = self
        searchBar.backgroundColor = .clear
        searchFriends = users
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        token?.invalidate()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchFriends?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: K.CellId.FriendsCell, for: indexPath) as? UserTableViewCell,
            let currentFriend = searchFriends?[indexPath.row]
        else { return UITableViewCell() }
        
        cell.configure(
            name: currentFriend.fullName,
            imageURL: currentFriend.userAvatarURL,
            photoService: photoService
            )

        return cell
    }

    // MARK SEARCH BAR
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == "" {
            searchFriends = users
      
        } else {
            searchFriends = searchFriends?.filter("firstName CONTAINS[cd] %@ OR lastName CONTAINS[cd] %@", searchBar.text!, searchBar.text!).sorted(byKeyPath: "firstName", ascending: true)
        }

        tableView.reloadData()
    }

    // MARK: - TableView Delegate Methods

     override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         defer { tableView.deselectRow(at: indexPath, animated: true) }
         performSegue(
             withIdentifier: K.Segue.showPhotoCollection,
             sender: nil)
     }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let
            destination = segue.destination as? PhotoCollectionViewController,
           let index = tableView.indexPathForSelectedRow?.row {
            destination.userID = searchFriends?[index].id
        }
    }
}

extension FriendsTableViewController {
    private func registerNib() {
        let nib = UINib(nibName: K.CellId.FriendsCell, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: K.CellId.FriendsCell)
    }
    private func observeRealm() {
        token = searchFriends?.observe({ changes in
            switch changes {
            case .initial( _):
                self.tableView.reloadData()
            case let .update(results, deletions, insertions, modifications):
                print(results, deletions, insertions, modifications)
                self.tableView.reloadData()
            case .error(let error):
                print(error)
            }
        })
    }
    private func makeRefreshControl(){
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    @objc private func refresh() {
        getUsers()
        
    }
    private func getUsers() {
        networkService.getFriends { [weak self] vkFriends in
            self?.tableView.refreshControl?.tintColor = .white
            self?.tableView.refreshControl?.endRefreshing()
            
            guard let friends = vkFriends else { return }
            do {
                try RealmService.save(items: friends)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    
}
//extension FriendsTableViewController: UITableViewDataSourcePrefetching {
//    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
//        guard
//            let maxRow = indexPaths.map({$0.row}).max(),  // .section ( for sections)
//            let users = self.users
//        else { return }
//        if
//            maxRow > users.count - 4,
//            !isLoading {
//            isLoading = true
//            networkService.getFriends { [weak self] users in
//                guard
//                    let self = self,
//                    let selfUsers = self.users,
//                    let users = users
//                else { return }
//                let indexSet = IndexSet(integersIn: selfUsers.count ..< selfUsers.count + users.count)
//                var userArr = [Friend]()
//                userArr.append(contentsOf: users)
//                self.tableView.insertSections(indexSet, with: .automatic)
//                self.tableView.insertRows(at: <#T##[IndexPath]#>, with: <#T##UITableView.RowAnimation#>)
//                self.isLoading = false
//                    
//            }
//            }
//    }
//    
//    
//}
