//
//  TimeSlotCell.swift
//  HealthGuruPro
//
//  Created by think360 on 11/09/17.
//  Copyright © 2017 bharat. All rights reserved.
//

import UIKit

class TimeSlotCell: UITableViewCell {
    
    @IBOutlet weak var TimeSlotlab: UILabel!
    @IBOutlet weak var CountLab: UILabel!
    @IBOutlet weak var clickedSlotImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
