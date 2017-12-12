//
//  CategoryListViewController.swift
//  CheckListApp
//
//  Created by Mahmoud Hosny on 4/25/17.
//  Copyright © 2017 Mahmoud Hosny. All rights reserved.
//

import UIKit

class CategoryListViewController : UITableViewController, AddCategoryViewControllerDelegate{
    
    
    var categories: [CategoryListItem]?
    var selectedCategoryIndex:Int?
    
    
    func addCategoryViewControllerDidCancel(_ controller: AddCategoryViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func addCategoryViewController(_ controller: AddCategoryViewController, didFinishAdding item: CategoryListItem, icon: IconListItem) {
        ModifyCategoryListItem(item, modifiedItem: nil)
        dismiss(animated: true, completion: nil)
    }
    
    func addCategoryViewController(_ controller: AddCategoryViewController, didFinishEditing item: CategoryListItem, icon: IconListItem) {
        ModifyCategoryListItem(nil, modifiedItem: item)
        dismiss(animated: true, completion: nil)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        
        categories = DAL.UnarchiveCategories()
        super.init(coder: aDecoder)
    }
    
    // did Select Row At
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        selectedCategoryIndex = indexPath.row
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  categories != nil{
            return categories!.count
        }else {
            return 0
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ItemsList" {
            // 2
            let controller = segue.destination as! ChecklistViewController
            // 4
            controller.delegate = self
        }else if segue.identifier == "AddCategory" {
            
            let navigationController = segue.destination as! UINavigationController
            // 3
            let controller = navigationController.topViewController as! AddCategoryViewController
            // 4
            controller.delegate = self
            controller.adding = true
        }else if segue.identifier == "EditCategory"{
            let navigationController = segue.destination as! UINavigationController
            // 3
            let controller = navigationController.topViewController as! AddCategoryViewController
            // 4
            controller.delegate = self
            controller.adding = false
            if let indexPath = tableView.indexPath(for: sender as!UITableViewCell){
                selectedCategoryIndex = indexPath.row
                controller.itemToEdit = categories![indexPath.row]
            }
        }
    }
    
    // return the needed cell to table view
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryListItemCell
        
        if categories != nil {
            let categoryListItem = categories![indexPath.row]
        
            configureText(for: cell, with: categoryListItem)
        }
        
        //cell.itemTitleLabel.text = "This Is Test Class !!"
        
        return cell
    }
    
    // commit editing style (swipe to delete)
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCellEditingStyle,
                            forRowAt indexPath: IndexPath) {
        categories!.remove(at: indexPath.row)
        archieveCategories()
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
    // Modifies the CategoryList to add Category or modify selected Category
    func ModifyCategoryListItem(_ newItem: CategoryListItem?, modifiedItem: CategoryListItem?) {
        if(categories == nil && modifiedItem == nil){
            categories = [CategoryListItem]()
        }
        
        var rowIndex: Int = 0
        if let newItem = newItem{
            rowIndex = categories!.count
            categories!.append(newItem)
        }
        if let modifiedItem = modifiedItem{
            rowIndex = selectedCategoryIndex!
            categories![rowIndex].categoryName = modifiedItem.categoryName
        }
        let indexPath = IndexPath(row: rowIndex, section: 0)
        let indexPaths = [indexPath]
        archieveCategories()
        if let _ = newItem{
            tableView.insertRows(at: indexPaths, with: .automatic)
        }
        if let _ = modifiedItem{
            tableView.reloadRows(at: indexPaths, with: .automatic)
        }
    }
    // updates the count of the currently added item to the Category
    func updateCategoryItemsCount(){
        let indexPath = IndexPath(row: selectedCategoryIndex!, section: 0)
        let indexPaths = [indexPath]
        
        tableView.reloadRows(at: indexPaths, with: .automatic)
        
    }
    
    // configure text on cell
    func configureText (for cell: CategoryListItemCell, with category: CategoryListItem) {
        cell.categoryNameLabel.text = category.categoryName
        cell.CategoryItemsCount.text = String(category.items.count)
        cell.categoryImage.image = category.categoryIcon.img
    }

    public func archieveCategories(){
        DAL.ArchiveCategories(categoriesArr: self.categories!)
    }
    
}
