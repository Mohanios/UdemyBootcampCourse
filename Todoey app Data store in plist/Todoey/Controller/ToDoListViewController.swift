//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var listItem = [Item]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var newItem = Item()
        newItem.title = "mohan"
        newItem.done = true
        listItem.append(newItem)
        
        var newItem1 = Item()
        newItem1.title = "mohan2"
        listItem.append(newItem1)
        
        var newItem2 = Item()
        newItem2.title = "mohan3"
        listItem.append(newItem2)
        
        var newItem3 = Item()
        newItem3.title = "mohan4"
        listItem.append(newItem3)
        
        LoadItem()
        
//        if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
//            listItem = items
//        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return listItem.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = listItem[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        //: Ternary operator
        //: value = condition ? .valueTrue : .valueFalse
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ ToDoItemCell: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        listItem[indexPath.row].done = !listItem[indexPath.row].done
        self.saveData()
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addItem(_ sender: Any) {
        
        var textfield = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            var newItem = Item()
            newItem.title = textfield.text!
            self.listItem.append(newItem)
            self.saveData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textfield = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    func saveData(){
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(listItem)
            try data.write(to: dataFilePath!)
        }catch{
            print("Error encoding listItem \(error)")
        }
        tableView.reloadData()
    }
    
    func LoadItem(){
        
            if let data = try? Data(contentsOf: dataFilePath!){
                let decoder = PropertyListDecoder()
                do{
                listItem = try decoder.decode([Item].self, from: data)
                }catch {
                    print("Error decoding listItem\(error)")
                }
        }
    }
    
    
}

