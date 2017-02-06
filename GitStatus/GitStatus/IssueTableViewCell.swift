//
//  IssueTableViewCell.swift
//  GitStatus
//
//  Created by MouseHouseApp on 2/5/17.
//  Copyright © 2017 Umar Khokhar. All rights reserved.
//

import UIKit

class IssueTableViewCell: UITableViewCell {

    @IBOutlet weak var issueTypeImage: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
