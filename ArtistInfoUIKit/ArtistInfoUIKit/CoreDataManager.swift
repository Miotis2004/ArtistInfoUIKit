//
//  CoreDataManager.swift
//  ArtistInfoUIKit
//
//  Created by Ronald Joubert on 2/11/21.
//

import Foundation
import CoreData

class CoreDataManager {
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ArtistInfo")
        
        container.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Something went wrong")
            }
        }
        return container
    }()
    
    func saveContext() {
        let context = self.persistentContainer.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                fatalError("Something went wrong saving data \(error.localizedDescription)")
            }
        }
    }
    
}
