//
//  CategoryViewController.swift
//  TodoeyRealm
//
//  Created by Leonard Groves on 9/15/22.
//

import UIKit
import RealmSwift
import SwipeCellKit

class CategoryViewController: SwipeTableViewController {
    
    let realm = try! Realm()
    
    // Results are auto-updating container type in Realm returned from object queries. Since they are auto-updating, we do not need to to append new categories to the categories variable, like we did when using Core Data or .plist files.
    var categories: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        // Location of the Realm database.
        // print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        loadCategories()
        
        // Increase the height of the table view cell to accomodate the swipe icons.
        tableView.rowHeight = 80.0
    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // The following returns the count of categories if categories is not nil. If categories is nil, it will return 1.
        return categories?.count ?? 1
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! SwipeTableViewCell

        // Configure the cell...
        
        // If cell.textLabel?.text is not nil, then make If cell.textLabel?.text equal to categories?[indexPath.row].name. If it is nil, then make it equal to "No categories added yet."
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No categories added yet."
        
        cell.delegate = self

        return cell
    }


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! ItemViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { action in
            
            let newCategory = Category()
            newCategory.name = textField.text!
            
            self.save(category: newCategory)
        }
        
        alert.addTextField() { alertTextField in
            
            alertTextField.placeholder = "Create new category"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    func save(category: Category) {
        
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving category. Error Message: \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadCategories() {
        
        categories = realm.objects(Category.self)
        
        tableView.reloadData()
    }
}

// The following was moved to the SwipeTableViewController class we created
/*
 // MARK: - Swipe Cell Delegate Methods
 
 extension CategoryViewController: SwipeTableViewCellDelegate {
 
 func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
 
 guard orientation == .right else { return nil }
 
 let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
 // handle action by updating model with deletion
 // print("Item deleted")
 
 if let item = self.categories?[indexPath.row] {
 do {
 try self.realm.write {
 self.realm.delete(item)
 }
 } catch {
 print("Error saving done status: \(error)")
 }
 
 // The following calls on the datasource methods and removes the row from the tableview that we just deleted from the database.
 // self.tableView.reloadData()
 }
 
 }
 
 // customize the action appearance
 deleteAction.image = UIImage(named: "delete-icon")
 
 return [deleteAction]
 }
 
 func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
 var options = SwipeOptions()
 options.expansionStyle = .destructiveAfterFill
 options.transitionStyle = .border
 return options
 }
 }
 */
