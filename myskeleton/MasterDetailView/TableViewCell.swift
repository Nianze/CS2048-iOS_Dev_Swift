//
//  TableViewCell.swift
//  MasterDetailView
//
//  Created by lnz on 9/24/16.
//  Copyright © 2016 CS2048 Instructor. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var functionLabel: UILabel!
    
    @IBOutlet weak var functionImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
