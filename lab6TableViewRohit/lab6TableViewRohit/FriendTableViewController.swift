//
//  FriendTableViewController.swift
//  lab6TableViewRohit
//
//  Created by Rohit Chauhan on 2024-07-16.
//

import UIKit

class FriendTableViewController: UITableViewController {

    
    var friendFirstName = ["Alice","Bob","Charlie","David","Eve","Frank","Grace","Hannah"];
    var friendPhone = ["555-1234","555-2345","555-3456","555-4567","555-5678","555-6789","555-7890","555-8901"];
    var friendEmail = ["alice@example.com","bob@example.com","charlie@example.com","david@example.com","eve@example.com","frank@example.com","grace@example.com","hannah@example.com"];
    var friendCarImage1 = [ UIImage (named: "accord"),
                       UIImage (named: "nexon"),
                       UIImage(named: "elantra"),
                       UIImage(named: "corolla"),
                       UIImage (named: "s123"),
                       UIImage(named: "hyader"),
                       UIImage(named: "tesla"),
                       UIImage(named: "ecosport"),
                      ]
    var friendCarImage2 = [ UIImage (named: "accord"),
                       UIImage (named: "nexon"),
                       UIImage(named: "elantra"),
                       UIImage(named: "corolla"),
                       UIImage (named: "s123"),
                       UIImage(named: "hyader"),
                       UIImage(named: "tesla"),
                       UIImage(named: "ecosport"),
                      ]
    var friendCarImage3 = [ UIImage (named: "accord"),
                       UIImage (named: "nexon"),
                       UIImage(named: "elantra"),
                       UIImage(named: "corolla"),
                       UIImage (named: "s123"),
                       UIImage(named: "hyader"),
                       UIImage(named: "tesla"),
                       UIImage(named: "ecosport"),
                      ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    @IBAction func `switch`(_ sender: UISwitch) {
        self.isEditing = sender.isOn
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return friendFirstName.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendCarCell", for: indexPath) as! FriendTableViewCell
        
        cell.firstName.text = friendFirstName[indexPath.row]
        cell.phone.text = friendPhone[indexPath.row]
        cell.email.text = friendEmail[indexPath.row]
        cell.image1.image = friendCarImage1[indexPath.row]
        cell.image2.image = friendCarImage2[indexPath.row]
        cell.image3.image = friendCarImage3[indexPath.row]

        
        // Configure the cell...

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            friendFirstName.remove(at: indexPath.row)
            friendPhone.remove(at: indexPath.row)
            friendEmail.remove(at: indexPath.row)
            friendCarImage1.remove(at: indexPath.row)
            friendCarImage2.remove(at: indexPath.row)
            friendCarImage3.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
            let movedFirstName = friendFirstName.remove(at: fromIndexPath.row)
            let movedPhone = friendPhone.remove(at: fromIndexPath.row)
            let movedEmail = friendEmail.remove(at: fromIndexPath.row)
            let movedCarImage1 = friendCarImage1.remove(at: fromIndexPath.row)
            let movedCarImage2 = friendCarImage2.remove(at: fromIndexPath.row)
            let movedCarImage3 = friendCarImage3.remove(at: fromIndexPath.row)

            friendFirstName.insert(movedFirstName, at: to.row)
            friendPhone.insert(movedPhone, at: to.row)
            friendEmail.insert(movedEmail, at: to.row)
            friendCarImage1.insert(movedCarImage1, at: to.row)
            friendCarImage2.insert(movedCarImage2, at: to.row)
            friendCarImage3.insert(movedCarImage3, at: to.row)

            tableView.reloadData()
        }

    
    
        @IBAction func addFriend(_ sender: UIBarButtonItem) {
            let alert = UIAlertController(title: "Add Friend", message: nil, preferredStyle: .alert)
            alert.addTextField { (textField) in
                textField.placeholder = "First Name"
            }
            alert.addTextField { (textField) in
                textField.placeholder = "Phone"
            }
            alert.addTextField { (textField) in
                textField.placeholder = "Email"
            }
            let addAction = UIAlertAction(title: "Add", style: .default) { [weak self] (_) in
                if let firstName = alert.textFields?[0].text,
                   let phone = alert.textFields?[1].text,
                   let email = alert.textFields?[2].text {
                    self?.friendFirstName.append(firstName)
                    self?.friendPhone.append(phone)
                    self?.friendEmail.append(email)
                    self?.friendCarImage1.append(UIImage(named: "defaultCar"))
                    self?.friendCarImage2.append(UIImage(named: "defaultCar"))
                    self?.friendCarImage3.append(UIImage(named: "defaultCar"))
                    self?.tableView.reloadData()
                }
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(addAction)
            alert.addAction(cancelAction)
            present(alert, animated: true, completion: nil)
        }

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
