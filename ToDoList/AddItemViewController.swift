//
//  AddItemViewController.swift
//  ToDoList
//
//  Created by Tilek Sulaymanbekov on 6/30/20.
//  Copyright © 2020 aslanarapbaev. All rights reserved.
//

import UIKit

protocol AddItemVCDelegate: class {
    func addItemVCDidCancel(_ controller: AddItemViewController)
    func addItemVC(_ controller: AddItemViewController, didFinishAdding item: ChecklistItem)
}

class AddItemViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    weak var delegate: AddItemVCDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
        //doneButton.isEnabled = false
    }

    @IBAction func cancel() {
        delegate?.addItemVCDidCancel(self)
    }

    @IBAction func done() {
        
        let item = ChecklistItem(text: textField.text!, checked: false)
        delegate?.addItemVC(self, didFinishAdding: item)
    }
    
    //MARK: - Table View Delegate
    //Убрать выбор ряда в сером цвете
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        
        doneButton.isEnabled = newText.isEmpty ? false : true
        
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        doneButton.isEnabled = false
        return true
    }
    
}
