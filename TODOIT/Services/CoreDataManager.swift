//
//  CoreDataManager.swift
//  TODOIT
//
//  Created by alekseienko on 16.03.2023.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
       
        let container = NSPersistentContainer(name: "TODOIT")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

    // MARK: - Create

extension CoreDataManager {
    
    func createTask() -> Task {
        let task = Task.init(context: self.persistentContainer.viewContext)
        return task
    }
}

    // MARK: - Get

extension CoreDataManager {
    
    func getAllTasks() -> [[Task]] {
        
        var tasks: [[Task]] = []
        
        let predicatePriority = NSPredicate(format: "priority > %d && isDone == FALSE", 0)
        let predicateNormal = NSPredicate(format: "priority == %d && isDone == FALSE", 0)
        let predicateDone = NSPredicate(format: "isDone == TRUE")
       
        tasks.append(getTasks(with: predicatePriority))
        tasks.append(getTasks(with: predicateNormal))
        tasks.append(getTasks(with: predicateDone))

        return tasks
    }
    
    private func getTasks(with predicate: NSPredicate) -> [Task] {
        
        let fetchReques = NSFetchRequest<Task>(entityName: "Task")
        let sortDescriptorDate = NSSortDescriptor(key: "date", ascending: true)
        fetchReques.sortDescriptors = [sortDescriptorDate]
        fetchReques.predicate = predicate
        do {
            let task = try self.persistentContainer.viewContext.fetch(fetchReques)
        
            return task
        } catch {
            fatalError()
        }
    }
}

    // MARK: - Delete

extension CoreDataManager {
    
    func deleteObject(object: NSManagedObject) {
        self.persistentContainer.viewContext.delete(object)
        self.saveContext()
    }
}
