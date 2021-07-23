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
        groups.append(group)

            tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: K.CellId.GroupCell, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: K.CellId.GroupCell)
    
        //fetch groups from the account
        networkService.getGroup { [weak self] vkGroups in
            guard
                let self = self,
                let groups = vkGroups
            else { return }
            self.groups = groups
        }
        
 
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
    
    
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = TableSectionHeaderView()
//        headerView.configure(with: "MY GROUPS")
//
//        return headerView
//    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
