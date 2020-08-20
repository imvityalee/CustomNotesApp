//
//  DisplayNoteViewController.swift
//  MakeSchoolNotes
//
//  Created by Chris Orcutt on 1/10/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import UIKit

class DisplayNoteViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var contetTextView: UITextView!
    
    
    var note: Note?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let note = note {
            titleTextField.text = note.title
            contetTextView.text = note.content
            
        } else {
            titleTextField.text = ""
            contetTextView.text = ""
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {return}
        
        
        switch identifier {
        case "cancel":
            print("cancel is tapped")
        case "save" where note == nil:
            //initilize new object, pases data to LisNoteTableViewControleer
            let note = CoreDataHelper.newNote()
            note.title = titleTextField.text ?? ""
            note.content = contetTextView.text ?? ""
            // set previous time to current time
            note.modificationTime = Date()
            
            CoreDataHelper.saveNote()
            
            
        case "save" where note != nil:
            note?.title = titleTextField.text ?? ""
            note?.content = contetTextView.text ?? ""
            note?.modificationTime = Date()
            
            CoreDataHelper.saveNote()
            
        default:
            print("unexpected segue is tapped")
        }
    }
    
}
