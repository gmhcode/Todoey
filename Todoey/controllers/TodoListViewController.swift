//
//  ViewController.swift
//  Todoey
//
//  Created by Greg Hughes on 11/20/18.
//  Copyright © 2018 Greg Hughes. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController  {

    var itemArray = [Item]()
    
//    let defaults = UserDefaults.standard
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
//        //this searches our files for the data of the app.
        
        print(dataFilePath)
        let newItem = Item()
        newItem.title = "Find Mike"
        
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Buy Eggos"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Destroy Demogorgon"
        itemArray.append(newItem3)
        
        loadItems()
        
//        if let items = defaults.array(forKey: "ToDoListArray") as? [Item]{
//            itemArray = items
//            //this makes itemArray take directly from saved data in the computer rather than from the app itself, so the info cant get deleted when assassinated
//        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    //Mark - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        // need to access the .title because item array is now the Item class
        
        //Ternary operatpr ==>
        //value = condition ? valueIfTrue : valueIfFalse
        
        
        cell.accessoryType = item.done == true ? .checkmark : .none
            //this says"set the cells accessoryType depending on whether item.done it true, if it is true, set it to .checkmark, if its not true then set it to done
        
        //^^ that does the same thing as vv that
//        if item.done == true{
//            cell.accessoryType = .checkmark
//        } else{
//            cell.accessoryType = .none
//        }
//        //^^ this says "when you select a row that already had a checkmark, then set the checkmark = none.. if the row didnt have a checkmark, then give it a checkmark
        
        return cell
    }
    
    
    
    
    //MARK - TableView Delegate Methods
    //does things when we select a row vv
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
////        ^^ this does the same as vv this, it basically turns "done" on and off, which in turn, turns the checkmark on and off
////        this says if you select a row that you didnt select before, then done will equal true, if not then done will == false
//        if itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//
//        }else {
//            itemArray[indexPath.row].done = false
//
//        }
//
        
        
        
        
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
            
            let newItem = Item()
            newItem.title = textField.text!
                //setting the title property of Item class to what the user typed in
            self.itemArray.append(newItem)
            //appending the alert text to the itemArray
            self.saveItems()
            
            

            
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
    
    func saveItems(){
        //saves encoded todo list on the computer
        let encoder = PropertyListEncoder()
        
        do{
            let data = try encoder.encode(itemArray)
            //since encoder.encode can throw and error, you need a do catch block
            try data.write(to: dataFilePath!)
        } catch {
            print("\(error)")
        }
        self.tableView.reloadData()
        //this do catch is telling the app to save all this data in a file on the computer, and its encoded
        //            self.defaults.set(self.itemArray, forKey: "toDoListArray")
        //            //this saves whatever is entered into add item
        //            //gets saved in a plist file
    }

    func loadItems() {
        //this function decodes the data that we stored in the plist on our computer
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            //we need this to decode all new entries in our plist on the computer
            do{
            itemArray = try decoder.decode([Item].self, from: data)
            }
            catch{
                print("\(error)")
                
            }
        }
    }
}



