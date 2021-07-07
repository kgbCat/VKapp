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
    private let groups = try? RealmService.load(typeOf: Groups.self)
    private var token: NotificationToken?

    @IBAction func addGroup(segue: UIStoryboardSegue) {
        guard
            segue.identifier == K.Segue.addGroup ,
            let SearchGroupsController = segue.source as? SearchGroupsTableViewController,
            let indexPath = SearchGroupsController.tableView.indexPathForSelectedRow
        else { return }
        let _ = SearchGroupsController.searchedGroups[indexPath.row]
            tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: K.CellId.GroupCell, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: K.CellId.GroupCell)
        observeRealm()
        //fetch groups from the account
        networkService.getGroup { vkGroups in
            guard let groups = vkGroups else { return }
            do {
                try RealmService.save(items: groups)
            } catch {
                print(error)
            }
        }
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
     
        return groups?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: K.CellId.GroupCell, for: indexPath) as? GroupTableViewCell,
            let currentGroup = groups?[indexPath.row]
        else { return UITableViewCell() }
             
        cell.configure(name: currentGroup.name, imageURL: currentGroup.photo)

        return cell
    }


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
extension GroupsTableViewController {
    
    private func observeRealm() {
        token = groups?.observe({ changes in
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
