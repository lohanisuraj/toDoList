//
//  CatogoryTableViewController.swift
//  todoApp
//
//  Created by IME Macmini on 19/05/2021.
//

import UIKit
import CoreData

class CatogoryTableViewController: UITableViewController {
    
    var catogoryArray = [Catogories]()
    


    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCatogories()
    }
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Categoty", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Catogoty", style: .default) { action in
            
            let newCatogory = Catogories(context: self.context)
            newCatogory.title = textField.text
            
            
            self.catogoryArray.append(newCatogory)
            self.saveCatogories()
            
            self.tableView.reloadData()
        }
        alert.addTextField { uitexField in
            uitexField.placeholder  = "Enter your new Catogory Here."
            textField = uitexField
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func saveCatogories(){
        do{
            try context.save()
        }catch{
            print(error)
        }
    }
    func loadCatogories(){
        let fetch:NSFetchRequest<Catogories> = Catogories.fetchRequest()
        do{
            catogoryArray = try context.fetch(fetch)
        }catch{
            print(error)
        }
    }
    
    
    //MARK:- Tableview DataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catogoryArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CatogoryCell", for: indexPath)
        cell.textLabel?.text = catogoryArray[indexPath.row].title
        return cell
    }
    
    //MARK:- tableview Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}
