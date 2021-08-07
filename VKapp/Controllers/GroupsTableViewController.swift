//
//  GroupsTableViewController.swift
//  VKapp
//
//  Created by Anna Delova on 7/6/21.
//

import UIKit
import RealmSwift

class GroupsTableViewController: UITableViewController {
    
    private let networkService = NetworkRequests()
    
    var groups = [MyGroups]() {
        didSet {
            tableView.reloadData()
        }
    }

    @IBAction func addGroup(segue: UIStoryboardSegue) {
        guard
            segue.identifier == K.Segue.addGroup ,
            let SearchGroupsController = segue.source as? SearchGroupsTableViewController,
            let indexPath = SearchGroupsController.tableView.indexPathForSelectedRow
        else { return }
        let group = SearchGroupsController.searchedGroups[indexPath.row]
        if !groups.contains(group) {
            groups.append(group)
            tableView.reloadData()
        }
      
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.title = "Groups"
        navigationController?.navigationBar.prefersLargeTitles = true
        makeRefreshControl()
        registerNib()
        getGroups()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return groups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: K.CellId.GroupCell, for: indexPath) as? GroupTableViewCell
        else { return UITableViewCell() }
    
        let currentGroup = groups[indexPath.row]
       
        cell.configure(name: currentGroup.name, imageURL: currentGroup.photo)

        return cell
    }
  
}

extension GroupsTableViewController {
    private func registerNib() {
        let nib = UINib(nibName: K.CellId.GroupCell, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: K.CellId.GroupCell)
    }
    private func makeRefreshControl(){
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    @objc private func refresh() {
        getGroups()
    }
    
    private func getGroups() {
        networkService.getGroup { [weak self] vkGroups in
            self?.tableView.refreshControl?.tintColor = .white
            self?.tableView.refreshControl?.endRefreshing()
            guard
                let self = self,
                let groups = vkGroups
            else { return }
            self.groups = groups
        }
    }
    
}
