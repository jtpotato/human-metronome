//
//  CoreDataController.swift
//  human-metronome
//
//  Created by Joel Tan on 19/9/2023.
//

import Foundation
import CoreData

class CoreDataController: ObservableObject {

    private let persistentContainer: NSPersistentContainer

    init() {
        persistentContainer = NSPersistentContainer(name: "Model")

        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Core Data store load failed: \(error.localizedDescription)")
            }
        }
    }

    func saveContext() {
        let context = persistentContainer.viewContext

        if context.hasChanges {
            do {
                try context.save()
            } catch {
                fatalError("Core Data save failed: \(error.localizedDescription)")
            }
        }
    }

}
