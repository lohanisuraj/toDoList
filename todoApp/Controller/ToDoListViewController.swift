//
//  ViewController.swift
//  todoApp
//
//  Created by IME Macmini on 16/05/2021.
//

import UIKit
import CoreData

class ToDoListViewController: UITableViewController {
    
    var selectedCatogotry: Catogories?{
        didSet{
            loadItems()
        }
    }
    
    
    var itemArray = [Items]()

        
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        //[Items(name: "Todo Quotes App Update", checkedMark: false),
       //              Items(name: "call with friends", checkedMark: false)]
    
    // ["Todo Quotes App Update","Wash clothes","call with friends"]
    //var itemArray = [Item]()
//    let defaults = UserDefaults.standard
    
    
 //   let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //let newItem = Item()
        // newItem.title = "great"
        //itemArray.append(newItem)
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
//        let newItem = Items(context: context)
//        newItem.name = "have breakfast"
//        newItem.checkedMark = false
//
//        itemArray.append(newItem)
        
       // print(filePath)
        
//        if let item = defaults.array(forKey: "TodoListArray") as? [TodoData]{
//            itemArray = item
//        }
       
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
        
        //title is changed
        //itemArray[indexPath.row].setValue("good morning", forKey: "name")
        
        //to delete item
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
//        
        
        //this is updating part
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
                
                newItem.parentCategory = self.selectedCatogotry
                
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
    func loadItems(with request: NSFetchRequest<Items> = Items.fetchRequest(),predicate: NSPredicate? = nil){
      //  let request: NSFetchRequest<Items> = Items.fetchRequest()
        
//        if let data = try? Data(contentsOf: filePath!){
//            let decoder = PropertyListDecoder()
//            do{
//                itemArray = try decoder.decode([Items].self, from: data)
//            }catch{
//                print("error in decoding")
//            }
//
//        }
        let catogororyPredicate = NSPredicate(format: "parentCategory.title MATCHES %@", selectedCatogotry!.title!)
        if let additionalPredicate = predicate{
            let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [catogororyPredicate,additionalPredicate])
            
            request.predicate = compoundPredicate
        }else{
            request.predicate = catogororyPredicate
        }
//
//        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [catogororyPredicate,predicate])
//
//        request.predicate = compoundPredicate
        do {
            itemArray = try context.fetch(request)
        }catch{
            print("error in fetching data \(error)")
        }
        tableView.reloadData()
    }
    
}
//MARK:- UISearchBarDelegate
extension ToDoListViewController : UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request: NSFetchRequest<Items> = Items.fetchRequest()
        
       let predicate = NSPredicate(format: "name CONTAINS[cd] %@", searchBar.text!)
        
        //request.predicate = predicate
        
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        //request.sortDescriptors = [sortDescriptor]
        
        loadItems(with: request,predicate: predicate)
        
//
//        do{
//            itemArray = try context.fetch(request)
//        }catch{
//            print(error)
//        }
//        tableView.reloadData()
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0{
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            
        }
    }
}

