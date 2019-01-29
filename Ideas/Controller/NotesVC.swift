//
//  NotesVC.swift
//  Ideas
//
//  Created by tarek bahie on 1/29/19.
//  Copyright © 2019 tarek bahie. All rights reserved.
//

import UIKit
import CoreData

class NotesVC: UITableViewController {

    
    var itemsArray = [Item]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var selectedIndex = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return itemsArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notesCell", for: indexPath)
        let item = itemsArray[indexPath.row]
        cell.textLabel?.text = item.name

        return cell
    }
 

   
    // MARK: - Data Manipulation
    
    func saveCategory() {
        do {
            try context.save()
        } catch {
            print("error Saving categories : \(error)")
        }
        tableView.reloadData()
        
    }
    
    func loadData () {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        do {
            itemsArray = try context.fetch(request)
        } catch {
            print("error loading Categories : \(error)")
        }
        tableView.reloadData()
    }
    
    @IBAction func addBtnPressede(_ sender: Any) {
        let alert = UIAlertController(title: "Add Note", message: "", preferredStyle: .alert)
        var textField = UITextField()
        alert.addTextField { (categoryTextField) in
            categoryTextField.placeholder = "Enter Note Text!"
            textField = categoryTextField
            
        }
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (UIAlertAction) in
            let newItem = Item(context: self.context)
            newItem.name = textField.text!
            newItem.body = ""
            self.itemsArray.append(newItem)
            self.saveCategory()
            if self.itemsArray.count > 0 {
                let endIndex = IndexPath(row: self.itemsArray.count - 1, section: 0)
                self.tableView.scrollToRow(at: endIndex, at: .bottom, animated: true)
            }
            
        }))
        present(alert, animated: true, completion: nil)
        
        
        
        
    }
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "goToNotes", sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         let destinationVC = segue.destination as! UpdateNotesVC
            destinationVC.item = itemsArray[selectedIndex]
    }
    
}
