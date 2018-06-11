//
//  ViewController.swift
//  Todolist
//
//  Created by Supapat on 11/6/2561 BE.
//  Copyright © 2561 Supapat. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = ["Find NEW","Buy Eggos"]
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let item = defaults.array(forKey: "TodoListArray") as? [String]{
            itemArray = item
        }
        
    }
    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    //MARK - Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //MARK - Addnewitem
    @IBAction func barButtonItem(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alertVC = UIAlertController(title: "Add new Item", message: "", preferredStyle: .alert)
        let actionVC = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // หลังคลิกแล้ว
            print("Success!")
            self.itemArray.append(textField.text!)
            self.defaults.setValue(self.itemArray, forKey: "TodoListArray")
            self.tableView.reloadData()
        }
        alertVC.addTextField { (alertTextField) in
            alertTextField.placeholder = "New Item"
            textField = alertTextField
        }
        alertVC.addAction(actionVC)
        present(alertVC,animated: true,completion: nil)
    }
    
}

