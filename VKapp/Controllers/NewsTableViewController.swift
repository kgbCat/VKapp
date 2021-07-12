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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: K.CellId.NewCell, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: K.CellId.NewCell)
        
        networkService.getNews { [weak self] Items, Profiles in
            guard
                let self = self,
                let items = Items,
                let profiles = Profiles
            else { return }
            self.items = items
            self.profiles = profiles
            dump(items)
            dump(profiles)
        }

    }
   
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//
//        guard
//            let cell = tableView.dequeueReusableCell(withIdentifier: K.CellId.NewCell, for: indexPath) as? NewsTableViewCell
//        else { return UITableViewCell() }
//        let currentItemNews = items[indexPath.row]
//
//        let attach = currentItemNews.attachments
        
//        let attach = currentItemNews.attachments
//        }
//        let currentProfile = profiles[indexPath.row]
////        cell.configure(userImageUrl = profiles
////        [0]?.photo.sizes[0]?.url
////        cell.configure(newsImageUrl: photo, text: currentItemNews.text, date: currentItemNews.text)

//        return cell
//
//    }
//   

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
