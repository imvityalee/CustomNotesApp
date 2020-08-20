//
//  ListNotesTableViewController.swift
//  MakeSchoolNotes
//
//  Created by Chris Orcutt on 1/10/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import UIKit

class ListNotesTableViewController: UITableViewController {
    
    var notes = [Note]() {
        //In the code above, we add syntax to create a property observer for our notes array. As the name suggests, the didSet observes the notes property. If the property changes the code within the didSet block is executed.
        didSet {
            tableView.reloadData()
        }

    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notes = CoreDataHelper.retrieveNote()

        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func  tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listNotesTableViewCell", for: indexPath) as! ListNotesTableViewCell
        
        let note = notes[indexPath.row]
        cell.noteTitleLabel.text = note.title
        cell.lastModifiedTimestepLabel.text = note.modificationTime?.convertToString() ?? "uknown"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let noteDelete = notes[indexPath.row]
            CoreDataHelper.deleteNote(note: noteDelete)
            
            notes = CoreDataHelper.retrieveNote()
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {return}
        
        switch identifier {
         // pass data back again to listNoteTabelViewController
        case "displayNote":
         // Get a reference to the index path of the selected row in the table view using the UITableView property named indexPathForSelectedRow. We'll use this next to retrieve the correct note in our notes array.
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            //Retrieve the selected note using the index path from the previous step.
            let note = notes[indexPath.row]
            // segue destintaion tyep cast to allwow us to set selected note to displatNoteviewcontroller note
            let destination = segue.destination as! DisplayNoteViewController
            // set selected note propery = to selected note
            destination.note = note
            
            
        case "addNote":
            print("create not bar button item tapped")
        default:
            print("unexpected error")
        }
    }
    
    
    @IBAction func unwindWithSegue(_ segue: UIStoryboardSegue) {
        notes = CoreDataHelper.retrieveNote()
        
    }
    

    

    
}
 
