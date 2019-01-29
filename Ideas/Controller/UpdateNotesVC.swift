//
//  UpdateNotesVC.swift
//  Ideas
//
//  Created by tarek bahie on 1/29/19.
//  Copyright © 2019 tarek bahie. All rights reserved.
//

import UIKit
import CoreData

class UpdateNotesVC: UIViewController {

    @IBOutlet weak var notesTxt: UITextView!
    
    var item : Item!
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureEntryData(entry: item!)
        // Do any additional setup after loading the view.
    }
    

    // MARK: - Navigation

  
    @IBAction func updateBtnPressed(_ sender: Any) {
        guard let newEntry = notesTxt.text else  {
            return
        }
        
       item!.body = newEntry
        saveItems()
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    func configureEntryData(entry: Item) {
        
        guard let text = entry.body else {
            return
        }
        
        notesTxt!.text = text
    }
    
    
    func saveItems() {
        do {
            try context.save()
        } catch {
            print("error Saving categories : \(error)")
        }
        
    }
}
