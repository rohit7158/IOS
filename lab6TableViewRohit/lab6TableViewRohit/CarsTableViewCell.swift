//
//  CarsTableViewCell.swift
//  lab6TableViewRohit
//
//  Created by Rohit Chauhan on 2024-07-16.
//

import UIKit

class CarsTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var CarImage: UIImageView!
    
    @IBOutlet weak var CarMake: UILabel!
    
    @IBOutlet weak var CarModel: UILabel!
    
    @IBOutlet weak var CarStyle: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
