//
//  GroupsTableViewCell.swift
//  TestAcer
//
//  Created by Charles You on 2017-04-27.
//  Copyright © 2017 Charles You. All rights reserved.
//

import UIKit

class GroupsTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var school_Course: UILabel!
    @IBOutlet weak var timePeriod: UILabel!
    @IBOutlet weak var location: UILabel!

    
}
