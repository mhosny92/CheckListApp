//
//  AddItemViewController.swift
//  CheckListApp
//
//  Created by Mahmoud Hosny on 4/21/17.
//  Copyright © 2017 Mahmoud Hosny. All rights reserved.
//

import UIKit
import Foundation

protocol AddItemViewControllerDelegate: class {
    func addItemViewControllerDidCancel(_ controller: AddItemViewController)
    func addItemViewController(_ controller: AddItemViewController,didFinishAdding item: CheckListItem)
    func addItemViewController(_ controller: AddItemViewController,didFinishEditing item: CheckListItem)
}

class AddItemViewController: UITableViewController, UITextFieldDelegate{

    @IBOutlet weak var itemToAddTextField: UITextField!
    
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    
    var itemToEdit : CheckListItem?
    weak var delegate: AddItemViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        itemToAddTextField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    @IBAction func cancel() {
        delegate?.addItemViewControllerDidCancel(self)
    }
    @IBAction func done() {
        dismiss(animated: true, completion: nil)
        let item = CheckListItem()
        item.itemText = itemToAddTextField.text!
        item.itemChecked = false
        if itemToEdit == nil{
        delegate?.addItemViewController(self, didFinishAdding: item)
        } else {
            itemToEdit?.itemText = item.itemText
            itemToEdit?.itemChecked = item.itemChecked
            delegate?.addItemViewController(self, didFinishEditing: itemToEdit!)
        }
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        let oldText = textField.text! as NSString
        let newText = oldText.replacingCharacters(in: range, with: string) as NSString
        doneBarButton.isEnabled = (newText.length > 0)
        
        return true
    }
}
