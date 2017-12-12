//
//  CheckListItem.swift
//  CheckListApp
//
//  Created by Mahmoud Hosny on 4/19/17.
//  Copyright © 2017 Mahmoud Hosny. All rights reserved.
//

import Foundation

class CheckListItem : NSObject, NSCoding{
    
    private struct propertyKey{
        static let itemText = "itemText"
        static let itemChecked = "itemChecked"
    }
    
    var itemText : String
    var itemChecked : Bool
    
    func toggleChecked() {
        itemChecked = !itemChecked
    }
    
    init(_ text: String, checked: Bool){
        self.itemText = text
        self.itemChecked = checked
    }
    
    override init(){
        itemText = ""
        itemChecked = false
    }
    
    required convenience init?(coder aDecoder: NSCoder){
        self.init()
        itemText = aDecoder.decodeObject(forKey: propertyKey.itemText) as? String ?? ""
        itemChecked = aDecoder.decodeBool(forKey: propertyKey.itemChecked)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(itemText, forKey: propertyKey.itemText)
        aCoder.encode(itemChecked, forKey: propertyKey.itemChecked)
    }
    
    
    
}
