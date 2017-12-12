//
//  CategoryListItemCell.swift
//  CheckListApp
//
//  Created by Mahmoud Hosny on 4/25/17.
//  Copyright © 2017 Mahmoud Hosny. All rights reserved.
//

import UIKit

class CategoryListItemCell: UITableViewCell {

    @IBOutlet var categoryNameLabel: UILabel!
    @IBOutlet weak var CategoryItemsCount: UILabel!
    @IBOutlet weak var categoryImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        categoryNameLabel.text = ""
    }
    

}
