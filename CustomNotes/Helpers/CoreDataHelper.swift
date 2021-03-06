//
//  CoreDataHelper.swift
//  MakeSchoolNotes
//
//  Created by Victor on 8/18/20.
//  Copyright © 2020 MakeSchool. All rights reserved.
//

import UIKit
import CoreData

struct CoreDataHelper  {
    
    static let context: NSManagedObjectContext = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError()
        }
        let persistentContainer = appDelegate.persistentContainer
        let context = persistentContainer.viewContext
        
        return context

    }()
    
    static func newNote() -> Note {
        
        let note = NSEntityDescription.insertNewObject(forEntityName: "Note", into: context) as! Note
        
        return note
        
        
    }
    
    static func saveNote()  {
        
        do {
            try context.save()
        } catch let error  {
            print("Could not save \(error.localizedDescription)")
        }
    }
    
    static func deleteNote(note: Note ) {
        
        context.delete(note)
        
         saveNote()
    }
    
    static func retrieveNote() -> [Note] {
        do {
            let fetchRequest = NSFetchRequest<Note>(entityName: "Note")
            let results = try context.fetch(fetchRequest)
            return results.reversed() // Displays by latest
        }catch let error {
            print("Could not save \(error.localizedDescription)")
        }
        
        return []
    }
    
    
    
}

