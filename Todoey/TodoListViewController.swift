//
//  ViewController.swift
//  Todoey
//
//  Created by Greg Hughes on 11/20/18.
//  Copyright © 2018 Greg Hughes. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController  {

    let itemArray = ["Find Mike","Buy eggos","Destroy Demogorgon"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    //Mark - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    //MARK - TableView Delegate Methods
    //does things when we select a row vv
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(itemArray[indexPath.row])
        
        if  tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark  {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        //^^ this says "when you select a row that already had a checkmark, then set the checkmark = none.. if the row didnt have a checkmark, then give it a checkmark
        
        tableView.deselectRow(at: indexPath, animated: true)
        //unhighlights the row we select it after we selected it
        
    }
    
    
}



