//
//  CategoryListItem.swift
//  CheckListApp
//
//  Created by Mahmoud Hosny on 4/25/17.
//  Copyright © 2017 Mahmoud Hosny. All rights reserved.
//

import Foundation


class CategoryListItem: NSObject, NSCoding{

    private struct propertyKey{
        static let categoryName = "categoryName"
        static let categoryItems = "categoryItems"
        static let categoryIcon = "categoryIcon"
    }
    
    var categoryName: String
    var items : [CheckListItem]
    var categoryIcon : IconListItem
    
    init(_ catName:String ,withItems:[CheckListItem], icon: IconListItem){
        categoryName = catName
        items = withItems
        categoryIcon = icon
    }
    
    override init(){
        categoryName = ""
        items = [CheckListItem]()
        categoryIcon = IconListItem(name: DAL.sharedInstance.icons[0].0, img: DAL.sharedInstance.icons[0].1!)
    }
    
    required  convenience init?(coder aDecoder: NSCoder) {
        self.init()
        categoryName = aDecoder.decodeObject(forKey: propertyKey.categoryName) as? String ?? ""
        items = (aDecoder.decodeObject(forKey: propertyKey.categoryItems) as? [CheckListItem])!
        //categoryIcon = aDecoder.decodeObject(forKey: propertyKey.categoryIcon) as! IconListItem
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(categoryName, forKey: propertyKey.categoryName)
        aCoder.encode(items, forKey: propertyKey.categoryItems)
        aCoder.encode(categoryIcon, forKey: propertyKey.categoryIcon)
    }
    
}

