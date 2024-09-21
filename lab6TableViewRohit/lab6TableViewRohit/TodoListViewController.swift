//
//  TodoListViewController.swift
//  lab6TableViewRohit
//
//  Created by Rohit Chauhan on 2024-07-16.
//

import UIKit

// Structure to represent a single todo item
struct ToDoItem {
    var title: String
    //var isCompleted: Bool
}

struct ToDoSection {
    var title: String
    var items: [ToDoItem]
}

class TodoListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // Array to hold all sections of todo items
    var sections: [ToDoSection] = [
        ToDoSection(title: "Design", items: [
            ToDoItem(title: "Sketch Vehicle"),
            ToDoItem(title: "Finalize Design")
        ]),
        ToDoSection(title: "Testing", items: [
            ToDoItem(title: "Brake Performance Test"),
            ToDoItem(title: "Evaluate Handling")
        ]),
        ToDoSection(title: "Manufacturing", items: [
            ToDoItem(title: "Order Chassis Components"),
            ToDoItem(title: "Review Assembly Line")
        ]),
        ToDoSection(title: "Maintenance", items: [
            ToDoItem(title: "Inspect Engine Oil"),
            ToDoItem(title: "Schedule Routine Servicing")
        ]),
        ToDoSection(title: "Tuning", items: [
            ToDoItem(title: "Adjust Suspension Settings"),
            ToDoItem(title: "Calibrate Engine for Efficiency")
        ]),
        ToDoSection(title: "Research", items: [
            ToDoItem(title: "Study New Lightweight"),
            ToDoItem(title: "Alternative Fuel Options")
        ]),
        ToDoSection(title: "Compliance", items: [
            ToDoItem(title: "Vehicle Meets Safety Standards"),
            ToDoItem(title: "Verify Emissions Compliance")
        ]),
        ToDoSection(title: "Prototype", items: [
            ToDoItem(title: "Build Scale Model Prototype"),
            ToDoItem(title: "Test Wind Resistance")
        ])
    ]


    
    @IBOutlet weak var editToggleSwitch: UISwitch!
    
    @IBOutlet weak var addSectionButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var addItemButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        editToggleSwitch.isOn = false

        // Do any additional setup after loading the view.
    }
    
    
    // Number of sections in the table view
    func numberOfSections(in tableView: UITableView) -> Int {
            return sections.count
        }
    
    // Title for each section in the table view
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return sections[section].title
        }
    
    // Number of rows in each section of the table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return sections[section].items.count
        }
    
    // Configure cells in the table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath)
            let item = sections[indexPath.section].items[indexPath.row]
            cell.textLabel?.text = item.title
            // Customize cell based on item.isCompleted if needed
            return cell
        }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            return true
        }
    
    // Handle row deletion in the table view
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                sections[indexPath.section].items.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
    
    
    
    // Action method for edit toggle switch value change
    @IBAction func editToggleSwitchChanged(_ sender: UISwitch) {
            tableView.isEditing = sender.isOn
        }
    
    // Action method to add a new section
    @IBAction func addSectionButtonTapped(_ sender: UIButton) {
            // Present an alert to enter new section name
            let alert = UIAlertController(title: "New Section", message: "Enter section name", preferredStyle: .alert)
            alert.addTextField { textField in
                textField.placeholder = "Section name"
            }

            let addAction = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
                guard let textField = alert.textFields?.first, let sectionTitle = textField.text, !sectionTitle.isEmpty else {
                    return
                }

                // Create a new section with the entered title
                let newSection = ToDoSection(title: sectionTitle, items: [])
                self?.sections.append(newSection)
                self?.tableView.reloadData()
            }
        
        // Action to clear the text field
        let clearAction = UIAlertAction(title: "Clear", style: .destructive) { _ in
                alert.textFields?.first?.text = ""
            }

        // Action to cancel adding a new section
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        // Add actions to the alert controller
            alert.addAction(addAction)
        alert.addAction(clearAction)
            alert.addAction(cancelAction)

            present(alert, animated: true, completion: nil)
        }

    // Action method for adding a new item to a section
        @IBAction func addItemButtonTapped(_ sender: UIButton) {
            if sections.isEmpty {
                // Handle if there are no sections yet
                return
            }

            // Present an action sheet to choose the section to add the item
            let actionSheet = UIAlertController(title: "Add Item", message: "Choose a section to add the item", preferredStyle: .actionSheet)

            for (index, section) in sections.enumerated() {
                let addAction = UIAlertAction(title: section.title, style: .default) { [weak self] _ in
                    self?.presentAddItemAlert(forSection: index)
                }
                actionSheet.addAction(addAction)
            }

            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            actionSheet.addAction(cancelAction)

            // For iPad support : specify the source view and rectangle for the popover presentation: reference from chat gpt
            if let popoverController = actionSheet.popoverPresentationController {
                popoverController.sourceView = sender
                popoverController.sourceRect = sender.bounds
            }

            present(actionSheet, animated: true, completion: nil)
        }

    // Method to present an alert for adding a new item to a specific section
        func presentAddItemAlert(forSection sectionIndex: Int) {
            let alert = UIAlertController(title: "New Item", message: "Enter item name", preferredStyle: .alert)
            alert.addTextField { textField in
                textField.placeholder = "Item title"
            }

            let addAction = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
                guard let textField = alert.textFields?.first, let itemTitle = textField.text, !itemTitle.isEmpty else {
                    return
                }

                // Create a new item and add it to the specified section
                let newItem = ToDoItem(title: itemTitle)
                self?.sections[sectionIndex].items.append(newItem)
                self?.tableView.reloadData()
            }
            
            let clearAction = UIAlertAction(title: "Clear", style: .destructive) { _ in
                    alert.textFields?.first?.text = ""
                }

            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

            alert.addAction(addAction)
            alert.addAction(clearAction)
            alert.addAction(cancelAction)

            present(alert, animated: true, completion: nil)
        }


        
    
        
       
    
    
        
        
        

   
   
    
        
        
        
        

    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
