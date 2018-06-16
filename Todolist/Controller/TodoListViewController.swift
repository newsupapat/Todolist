//
//  ViewController.swift
//  Todolist
//
//  Created by Supapat on 11/6/2561 BE.
//  Copyright © 2561 Supapat. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
    var itemArray = [Item]()
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a
        print("plist file \(dataFilePath!)")
        let newItem = Item()
        newItem.title = "Find New"
        itemArray.append(newItem)
        loadItems()
//        if let item = defaults.array(forKey: "TodoListArray") as? [Item]{
//                itemArray = item}
        
        
    }
    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = itemArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        //Ternary operator
        cell.accessoryType = item.done == true ? .checkmark : .none
        
        return cell
    }
    
    //MARK - Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(indexPath.row)
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        self.save()
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //MARK - Addnewitem
    @IBAction func barButtonItem(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alertVC = UIAlertController(title: "Add new Item", message: "", preferredStyle: .alert)
        let actionVC = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // หลังคลิกแล้ว
            print("Success!")
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            //self.defaults.setValue(self.itemArray, forKey: "TodoListArray")
            self.save()
        }
        alertVC.addTextField { (alertTextField) in
            alertTextField.placeholder = "New Item"
            textField = alertTextField
        }
        alertVC.addAction(actionVC)
        present(alertVC,animated: true,completion: nil)
    }
    func save(){
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(self.itemArray)
            try data.write(to: self.dataFilePath!)
        }catch{
            print("\(error)")
        }
        self.tableView.reloadData()
    }
    func  loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
                itemArray = try decoder.decode([Item].self, from: data)
               }catch{
                print("\(error)")
            }
        }
    }
}

