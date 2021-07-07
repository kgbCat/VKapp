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
    
    var searchFriends: Results<Friend>?
    
    private var token: NotificationToken?
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        observeRealm()
        
        let nib = UINib(nibName: K.CellId.FriendsCell, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: K.CellId.FriendsCell)
        
        searchBar.delegate = self
        searchBar.backgroundColor = .clear
        
        networkService.getFriends { vkFriends in
            guard let friends = vkFriends else { return }
            do {
                try RealmService.save(items: friends)
            } catch {
                print(error)
            }
        }
        
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
            imageURL: currentFriend.userAvatarURL
            )

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
//             Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
    }
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
    
    
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

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
            destination.userID = users?[index].id
//            print(users?[index].id ?? 0)

        }
    }
}

extension FriendsTableViewController {
    private func observeRealm() {
        token = users?.observe({ changes in
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
}
