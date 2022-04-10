//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class ToDoListViewController: UITableViewController,UIPickerViewDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    var listItem = [Item]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self

        LoadItem()
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
        
        //: CoreData Delete Code
//        context.delete(listItem[indexPath.row])
//        listItem.remove(at: indexPath.row)
        
        self.saveData()
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addItem(_ sender: Any) {
        
        var textfield = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
           
            let newItem = Item(context: self.context)
            newItem.title = textfield.text!
            newItem.done = false
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
        do{
            try context.save()
        }catch{
            print("Error save context \(error)")
        }
        tableView.reloadData()
    }
    
    func LoadItem(with request : NSFetchRequest<Item> = Item.fetchRequest()){
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        do {
            listItem = try context.fetch(request)
        }catch{
            print("Error fetching data from context \(error)")
        }
    }
    
   
}

extension ToDoListViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        LoadItem(with: request)
    }
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchBar.text?.count == 0 {
//            LoadItem()
//        }
//    }
}
