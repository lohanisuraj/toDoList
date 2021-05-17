//
//  ViewController.swift
//  todoApp
//
//  Created by IME Macmini on 16/05/2021.
//

import UIKit
import CoreData

class ToDoListViewController: UITableViewController {
    
    var itemArray = [Items]()
        
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        //[Items(name: "Todo Quotes App Update", checkedMark: false),
       //              Items(name: "call with friends", checkedMark: false)]
    
    // ["Todo Quotes App Update","Wash clothes","call with friends"]
    //var itemArray = [Item]()
//    let defaults = UserDefaults.standard
    
    
    let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let newItem = Item()
        // newItem.title = "great"
        //itemArray.append(newItem)
        
        
        let newItem = Items(context: context)
        newItem.name = "have breakfast"
        newItem.checkedMark = false
        
        
        itemArray.append(newItem)
        
       // print(filePath)
        
//        if let item = defaults.array(forKey: "TodoListArray") as? [TodoData]{
//            itemArray = item
//        }
//         loadItems()
        
    }
    
    //MARK:- tableviewDatasource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.name
        
        cell.accessoryType = item.checkedMark ? .checkmark : .none
        
        
        return cell
    }
    
    //MARK:- TableViewDelegate Method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
      
            
        itemArray[indexPath.row].checkedMark = !itemArray[indexPath.row].checkedMark
            
     
        saveItem()
      
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //to add items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todo Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { action in
            if let data = textField.text{
                let newItem = Items(context: self.context)
                newItem.name = data
                newItem.checkedMark = false
                
                self.itemArray.append(newItem)
                
                //self.defaults.setValue(self.itemArray, forKey: "TodoListArray")
                self.saveItem()
                
            }
            
        }
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Enter new Item Here."
            textField = alertTextField
            
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func saveItem(){
//        let encoder = PropertyListEncoder()
        do{
//            let datas = try encoder.encode(itemArray)
//            try datas.write(to: filePath!)
            try context.save()
            
        }catch{
//            print("error in encoding")
            print("error saving context\(error)")
        }
        self.tableView.reloadData()
    }
//    func loadItems(){
//        if let data = try? Data(contentsOf: filePath!){
//            let decoder = PropertyListDecoder()
//            do{
//                itemArray = try decoder.decode([Items].self, from: data)
//            }catch{
//                print("error in decoding")
//            }
//
//        }
//    }
    
}

