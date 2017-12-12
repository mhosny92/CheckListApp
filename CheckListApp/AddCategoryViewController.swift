//
//  AddCategoryViewController.swift
//  CheckListApp
//
//  Created by Mahmoud Hosny on 4/26/17.
//  Copyright © 2017 Mahmoud Hosny. All rights reserved.
//

import Foundation
import UIKit

protocol AddCategoryViewControllerDelegate: class {
    func addCategoryViewControllerDidCancel(_ controller: AddCategoryViewController)
    func addCategoryViewController(_ controller: AddCategoryViewController,didFinishAdding item: CategoryListItem, icon: IconListItem)
    func addCategoryViewController(_ controller: AddCategoryViewController,didFinishEditing item: CategoryListItem, icon: IconListItem)
}
class AddCategoryViewController :UITableViewController, AddIconViewControllerDelegate
{
    
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    @IBOutlet weak var enteredCategoryTextField: UITextField!
    
    var delegate: AddCategoryViewControllerDelegate!
    var itemToEdit: CategoryListItem?
    var adding: Bool?
    var selectedIcon: IconListItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        enteredCategoryTextField.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func AddIconViewControllerDidCancel(_ controller: AddIconViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func AddIconViewController(_ controller: AddIconViewController, didFinishAdding icon: IconListItem) {
        //dismiss(animated: true, completion: nil)
        selectedIcon = icon
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddIcon" {
            // 2
            let controller = segue.destination as! AddIconViewController
            // 4
            controller.delegate = self
        }
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    @IBAction func cancel() {
        //        dismiss(animated: true, completion: nil)
        delegate?.addCategoryViewControllerDidCancel(self)
    }
    @IBAction func done() {
        dismiss(animated: true, completion: nil)
        let item = CategoryListItem()
        item.categoryName = enteredCategoryTextField.text!
        if self.adding!{
            if let selectedIcon = selectedIcon{
                delegate.addCategoryViewController(self, didFinishAdding: item, icon: selectedIcon)
            }else {
                let (name, img) = DAL.sharedInstance.NoIconImage()
                selectedIcon = IconListItem(name: name, img: img)
                delegate.addCategoryViewController(self, didFinishAdding: item, icon: selectedIcon!)
            }
        }else {
            if let selectedIcon = selectedIcon{
                delegate.addCategoryViewController(self, didFinishEditing: item, icon: selectedIcon)
            }else {
                let (name, img) = DAL.sharedInstance.NoIconImage()
                selectedIcon = IconListItem(name: name, img: img)
                delegate.addCategoryViewController(self, didFinishEditing: item, icon: selectedIcon!)
            }
        }
        
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        let oldText = textField.text! as NSString
        let newText = oldText.replacingCharacters(in: range, with: string) as NSString
        doneButton.isEnabled = (newText.length > 0)
        
        return true
    }

}
