//
//  ViewController.swift
//  Todoey
//
//  Created by Greg Hughes on 11/20/18.
//  Copyright © 2018 Greg Hughes. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController  {

    var itemArray = ["Find Mike","Buy eggos","Destroy Demogorgon"]
    
    let defaults = UserDefaults.standard
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let items = defaults.array(forKey: "ToDoListArray") as? [String]{
            itemArray = items
            //this makes itemArray take directly from saved data in the computer rather than from the app itself, so the info cant get deleted when assassinated
        }
        
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
    // MARK - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        //creating this so we can use it in ther alerttextfield area AND in the button pressed area
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        // creates an alert when you tap the + button
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user clicks the Add Item button on our UIAlert
            print("success")
            
            self.itemArray.append(textField.text!)
            //appending the alert text to the itemArray
            
            self.defaults.set(self.itemArray, forKey: "toDoListArray")
            //this saves whatever is entered into add item
            //gets saved in a plist file
            
            self.tableView.reloadData()
            //need to reload the tableView so our new item will appear in the table
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            print(alertTextField.text)
            
            textField = alertTextField
            
            //this adds a text field to the alert
        }
        
        alert.addAction(action)
        //adds the action we made to the alert we made
        
        present(alert, animated: true, completion: nil)
        //makes the alert pop on on the screen
    }
    
}



