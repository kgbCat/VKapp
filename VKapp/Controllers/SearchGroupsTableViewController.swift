//
//  SearchGroupsTableViewController.swift
//  VKapp
//
//  Created by Anna Delova on 7/6/21.
//

import UIKit

class SearchGroupsTableViewController: UITableViewController, UISearchBarDelegate {
    
    private let networkService = NetworkRequests()

     var searchedGroups = [MyGroups]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeRefreshControl()
        registerNib()
        searchBar.delegate = self
        searchBar.backgroundColor = .clear
        


    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: K.CellId.GroupCell, for: indexPath) as? GroupTableViewCell
        else { return UITableViewCell() }
        let currentGroup = searchedGroups[indexPath.row]
        cell.configure(
            name: currentGroup.name,
            imageURL: currentGroup.photo )
        return cell
    }
    
    // MARK: - Table view delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: K.Segue.addGroup,
                     sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    //     MARK SEARCH BAR
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if searchBar.text != "" {
                searchGroups()
                searchBar.backgroundColor = UIColor(.yellow)
                tableView.reloadData()
            }
        }
    
}
extension SearchGroupsTableViewController {
    private func registerNib() {
        let nib = UINib(nibName: K.CellId.GroupCell, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: K.CellId.GroupCell)
    }
    private func makeRefreshControl(){
        // Refresh
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    @objc private func refresh() {
        searchGroups()
    }
    
    private func searchGroups() {
        networkService.searchGroups(search: searchBar.text!) { [weak self] VKGroups in
            self?.tableView.refreshControl?.tintColor = .white
            self?.tableView.refreshControl?.endRefreshing()
            guard
                let self = self,
                let groups = VKGroups
            else {return}
            self.searchedGroups = groups
        }
    }
}
