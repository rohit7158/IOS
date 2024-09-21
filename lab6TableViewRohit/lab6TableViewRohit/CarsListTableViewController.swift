import UIKit

class CarsListTableViewController: UITableViewController {

    var carMake = ["Honda", "Tata", "Hyundai", "Toyota", "BMW", "Merc", "Tesla", "Ford"]
    var carModel = ["Accord", "Nexon", "Elantra", "Corolla", "S123", "Hyader", "Tesla1", "Ecosport"]
    var carStyle = ["Sedan", "Sedan", "Sedan", "Sedan", "Sedan", "Sedan", "Sedan", "Hatchback"]
    var carImages = [ UIImage(named: "accord"),
                      UIImage(named: "nexon"),
                      UIImage(named: "elantra"),
                      UIImage(named: "corolla"),
                      UIImage(named: "s123"),
                      UIImage(named: "hyader"),
                      UIImage(named: "tesla"),
                      UIImage(named: "ecosport") ]
    
    let defaultCarImage = UIImage(named: "accord")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the navigation bar button item
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCar))
    }
    
    @IBAction func `switch`(_ sender: UISwitch) {
        self.isEditing = sender.isOn
    }
    
    @IBAction func addCarToList(_ sender: UIButton) {
        addCar()
    }
    
    @objc func addCar() {
        let alert = UIAlertController(title: "New Car", message: "Enter car details", preferredStyle: .alert)

        alert.addTextField { (textField) in
            textField.placeholder = "Make"
        }

        alert.addTextField { (textField) in
            textField.placeholder = "Model"
        }

        let addAction = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            guard let make = alert.textFields?[0].text, !make.isEmpty,
                  let model = alert.textFields?[1].text, !model.isEmpty else {
                return
            }

            // Add new car details to the arrays
            self?.carMake.append(make)
            self?.carModel.append(model)
            self?.carStyle.append("Sedan") // Default style or you can add another text field for style
            self?.carImages.append(self?.defaultCarImage)

            self?.tableView.reloadData()
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alert.addAction(addAction)
        alert.addAction(cancelAction)

        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carMake.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "carCell", for: indexPath) as! CarsTableViewCell
        
        let carMake = self.carMake[indexPath.row]
        let carModel = self.carModel[indexPath.row]
        let carStyle = self.carStyle[indexPath.row]
        let carImage = self.carImages[indexPath.row]
        
        cell.CarMake.text = carMake
        cell.CarModel.text = carModel
        cell.CarStyle.text = carStyle
        cell.CarImage.image = carImage

        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Remove car details from arrays
            carMake.remove(at: indexPath.row)
            carModel.remove(at: indexPath.row)
            carStyle.remove(at: indexPath.row)
            carImages.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let movedCarMake = carMake.remove(at: fromIndexPath.row)
        carMake.insert(movedCarMake, at: to.row)
        
        let movedCarModel = carModel.remove(at: fromIndexPath.row)
        carModel.insert(movedCarModel, at: to.row)
        
        let movedCarStyle = carStyle.remove(at: fromIndexPath.row)
        carStyle.insert(movedCarStyle, at: to.row)
        
        let movedCarImage = carImages.remove(at: fromIndexPath.row)
        carImages.insert(movedCarImage, at: to.row)
        
        tableView.reloadData()
    }
}
