//
//  IconListItem.swift
//  CheckListApp
//
//  Created by Mahmoud Hosny on 4/29/17.
//  Copyright © 2017 Mahmoud Hosny. All rights reserved.
//

import Foundation
import UIKit

class IconListItem: NSObject, NSCoding{
    
    private struct PropertyKey{
        static let img = "img"
        static let imgName = "imgName"
    }
    
    var img: UIImage
    var imgName: String
    
    override init(){
        img = UIImage()
        imgName = ""
    }
    
    init(name:String, img: UIImage){
        self.img = img
        self.imgName = name
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.img = (aDecoder.decodeObject(forKey: PropertyKey.img)! as? UIImage)!
        self.imgName = (aDecoder.decodeObject(forKey: PropertyKey.imgName) as? String)!
        
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(img, forKey:PropertyKey.img)
        aCoder.encode(imgName, forKey: PropertyKey.imgName)
    }
    
}
