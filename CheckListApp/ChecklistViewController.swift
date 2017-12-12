//
//  ViewController.swift
//  CheckListApp
//
//  Created by Mahmoud Hosny on 4/17/17.
//  Copyright © 2017 Mahmoud Hosny. All rights reserved.
//


// Page 109

import UIKit



class ChecklistViewController: UITableViewController, AddItemViewControllerDelegate {

    
    var delegate: CategoryListViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    func addItemViewControllerDidCancel(
        _ controller: AddItemViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func addItemViewController(_ controller: AddItemViewController,
                               didFinishAdding item: CheckListItem) {
        addItem(item)
        delegate!.archieveCategories()
        dismiss(animated: true, completion: nil)
    }
    
    func addItemViewController(_ controller: AddItemViewController, didFinishEditing item: CheckListItem) {
        let newRowIndex = delegate!.categories![delegate!.selectedCategoryIndex!].items.index(of: item)!
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        delegate!.archieveCategories()
        tableView.reloadRows(at: indexPaths, with: .automatic)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 1
        if segue.identifier == "addItem" {
            // 2
            let navigationController = segue.destination as! UINavigationController
            // 3
            let controller = navigationController.topViewController as! AddItemViewController
            // 4
            controller.delegate = self
        }else if segue.identifier == "editItem"{
            let navigationCOntroller = segue.destination as! UINavigationController
            let controller = navigationCOntroller.topViewController as!
                AddItemViewController
            
            controller.delegate = self
            
            if let indexPath = tableView.indexPath(for: sender as!UITableViewCell){
                controller.itemToEdit = delegate!.categories![delegate!.selectedCategoryIndex!].items[indexPath.row]
            }
        }
        
    }
    
    
    // return the needed cell to table view
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckListCell", for: indexPath) as! CheckListItemCell
        
        let checkListItem = delegate!.categories![delegate!.selectedCategoryIndex!].items[indexPath.row]
        
        configureText(for: cell, with: checkListItem)
        
        configureCheckMark(for: cell, with: checkListItem)
        
        return cell
    }

    // number Of Rows In Section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate!.categories![delegate!.selectedCategoryIndex!].items.count
    }
    
    // did Select Row At
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let checkListItem = delegate!.categories![delegate!.selectedCategoryIndex!].items[indexPath.row]
        checkListItem.toggleChecked()
        
        if let cell = tableView.cellForRow(at: indexPath) as? CheckListItemCell {
            configureCheckMark(for: cell, with: checkListItem)
        }
        delegate!.archieveCategories()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // commit editing style (swipe to delete)
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCellEditingStyle,
                            forRowAt indexPath: IndexPath) {
        delegate!.categories![delegate!.selectedCategoryIndex!].items.remove(at: indexPath.row)
        delegate!.archieveCategories()
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
    // add Item to Table View
    func addItem(_ item: CheckListItem) {
        
        let newRowIndex = delegate!.categories![delegate!.selectedCategoryIndex!].items.count
    
        delegate!.categories![delegate!.selectedCategoryIndex!].items.append(item)
        
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        delegate!.updateCategoryItemsCount()
    }
    
    // configure check mark on cell
    func configureCheckMark (for cell: CheckListItemCell, with item: CheckListItem) {
        cell.itemCheckLabel.text = item.itemChecked ? "✔️" : ""
    }
    
    // configure text on cell
    func configureText (for cell: CheckListItemCell, with item: CheckListItem) {
        cell.itemTitLabel.text = item.itemText
    }
    
}

