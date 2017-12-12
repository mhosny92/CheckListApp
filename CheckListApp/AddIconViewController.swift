//
//  AddIconViewController.swift
//  CheckListApp
//
//  Created by Mahmoud Hosny on 4/29/17.
//  Copyright © 2017 Mahmoud Hosny. All rights reserved.
//

import Foundation
import UIKit

protocol AddIconViewControllerDelegate{
    func AddIconViewControllerDidCancel(_ controller: AddIconViewController)
    func AddIconViewController(_ controller: AddIconViewController, didFinishAdding icon: IconListItem)
}
class AddIconViewController: UITableViewController{
    
    var delegate: AddIconViewControllerDelegate!
    
    let icons = DAL.sharedInstance.icons
    var selectedIconIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIconIndex = indexPath.row
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return icons.count
    }
    @IBAction func Done(_ sender: UIBarButtonItem) {
        navigationController!.popViewController(animated: true)
        let icon = IconListItem(name: icons[selectedIconIndex].0, img: icons[selectedIconIndex].1!)
        delegate.AddIconViewController(self, didFinishAdding: icon)
    }
    
    @IBAction func Cancel(_ sender: UIBarButtonItem) {
        delegate.AddIconViewControllerDidCancel(self)
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IconCell", for: indexPath) as! IconListItemCell
        
        
        let item = IconListItem(name: icons[indexPath.row].0, img: icons[indexPath.row].1!)
        ConfigureIconCell(for: cell, with: item)
        
        return cell
    }
    
    func ConfigureIconCell(for cell: IconListItemCell, with item: IconListItem){
        cell.imgName.text = item.imgName
        cell.imgView.image = item.img
    }
    
    
}
