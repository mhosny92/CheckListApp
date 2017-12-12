//
//  DAL.swift
//  CheckListApp
//
//  Created by Mahmoud Hosny on 4/28/17.
//  Copyright © 2017 Mahmoud Hosny. All rights reserved.
//

import Foundation
import UIKit

class DAL{

    let icons = [
        ("No Icon", UIImage(named: "No Icon")),
        ("Appointments", UIImage(named: "Appointments")) ,
        ("Birthdays", UIImage(named: "Birthdays")),
        ("Chores", UIImage(named: "Chores")),
        ("Drinks", UIImage(named: "Drinks")),
        ("Folder", UIImage(named: "Folder")),
        ("Groceries", UIImage(named: "Groceries")),
        ("Photos", UIImage(named: "Photos")),
        ("Trips", UIImage(named: "Trips")),
        ("Inbox", UIImage(named: "Inbox")),
    ]
    
    static let sharedInstance : DAL = {
        let instance = DAL()
        return instance
    }()
    
    func NoIconImage() -> (String, UIImage){
        return (icons[0].0, icons[0].1!)
    }
    
    private init(){}
    
    
    private static func documentsDirectory () -> URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    private static func dataFilePath() -> URL{
        return documentsDirectory().appendingPathComponent("checklists.plist")
    }
    
    static func ArchiveCategories(categoriesArr: [CategoryListItem]){
        NSKeyedArchiver.archiveRootObject(categoriesArr, toFile: dataFilePath().path)
    }
    
    static func UnarchiveCategories()->[CategoryListItem]?{
        let categories = NSKeyedUnarchiver.unarchiveObject(withFile: dataFilePath().path) as? [CategoryListItem]
        return categories
    }
    
}
