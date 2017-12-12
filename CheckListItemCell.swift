//
//  CheckListCell.swift
//  CheckListApp
//
//  Created by KARIM on 4/17/17.
//  Copyright © 2017 Mahmoud Hosny. All rights reserved.
//

import UIKit

class CheckListItemCell: UITableViewCell {

    @IBOutlet var itemTitLabel: UILabel!
    
    @IBOutlet var itemCheckLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        itemTitLabel.text = ""
    }

}
