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
    // register nib for NewsCellProfile
        let nib1 = UINib(nibName: K.CellId.NewsCellProfile, bundle: nil)
        tableView.register(nib1, forCellReuseIdentifier: K.CellId.NewsCellProfile)
    // register nib for NewsCellItem
        let nib2 = UINib(nibName: K.CellId.NewsCellItem, bundle: nil)
        tableView.register(nib2, forCellReuseIdentifier: K.CellId.NewsCellItem)
    // get data
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
        
       
        for profile in profiles {
            idProfile.append(profile.id)
        }
        for item in items {
            idItem.append(item.source_id)
        }

    }
   
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count + profiles.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
  
        if indexPath.row == 0{
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
