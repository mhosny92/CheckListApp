//
//  IconListItemCell.swift
//  CheckListApp
//
//  Created by Mahmoud Hosny on 4/29/17.
//  Copyright © 2017 Mahmoud Hosny. All rights reserved.
//

import Foundation
import UIKit

class IconListItemCell: UITableViewCell{
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var imgName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        imgName.text = ""
    }

    
}
