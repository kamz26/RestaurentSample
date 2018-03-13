//
//  WaitingListCell.swift
//  RestaurentSample
//
//  Created by admin on 10/03/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class WaitingListCell: UITableViewCell {

    
    @IBOutlet weak var name:UILabel?
    @IBOutlet weak var phoneNumber:UILabel?
    @IBOutlet weak var numberOfpeople:UILabel?
    @IBOutlet weak var count:UILabel?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
