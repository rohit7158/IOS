//
//  FriendTableViewCell.swift
//  lab6TableViewRohit
//
//  Created by Rohit Chauhan on 2024-07-16.
//

import UIKit

class FriendTableViewCell: UITableViewCell {

    
    @IBOutlet weak var firstName: UILabel!
    
    
    @IBOutlet weak var phone: UILabel!
    
    
    @IBOutlet weak var email: UILabel!
    
    
    @IBOutlet weak var image1: UIImageView!
    
    
    @IBOutlet weak var image2: UIImageView!
    
    
    @IBOutlet weak var image3: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
