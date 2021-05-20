//
//  CatogoryTableViewController.swift
//  todoApp
//
//  Created by IME Macmini on 19/05/2021.
//

import UIKit
import CoreData

class CatogoryTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }


    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
    }
    
    
    //MARK:- Tableview DataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CatogoryCell", for: indexPath)
        cell.textLabel?.text = "hello"
        return cell
    }
    
    //MARK:- tableview Delegate
    
}
