import UIKit

class ToDoTableViewController: UITableViewController {

    var sections: [String] = ["Personal", "Work"]  // Example sections
    var toDoItems: [[String]] = [["Buy groceries", "Call mom"], ["Finish report", "Prepare presentation"]]  // Example to-do items grouped by sections

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        // Register cell classes if necessary
        // self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        
        // Setup your UI or load data
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let toDoItem = toDoItems[indexPath.section][indexPath.row]
        cell.textLabel?.text = toDoItem
        // Configure cell...
        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            toDoItems[indexPath.section].remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            // Update your data model or storage
        }
    }

    // MARK: - User Actions

    @IBAction func addNewItem(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "New To-Do Item", message: "Enter the new to-do item", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "To-Do Item"
        }
        
        // Add action buttons
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak self, weak alert] _ in
            if let textField = alert?.textFields?.first, let newItem = textField.text, !newItem.isEmpty {
                // Add new item to the first section for simplicity
                self?.toDoItems[0].append(newItem)
                let indexPath = IndexPath(row: (self?.toDoItems[0].count ?? 1) - 1, section: 0)
                self?.tableView.insertRows(at: [indexPath], with: .automatic)
                // Update your data model or storage as needed
            }
        }))
        
        // Present the alert
        self.present(alert, animated: true, completion: nil)
    }

    // You can add more actions or methods as needed

}
