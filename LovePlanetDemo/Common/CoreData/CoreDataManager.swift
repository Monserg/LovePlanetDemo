//
//  CoreDataManager.swift
//  OmnieCommerce
//
//  Created by msm72 on 20.02.17.
//  Copyright © 2017 Omniesoft. All rights reserved.
//

import CoreData
import Foundation

class CoreDataManager {
    // MARK: - Properties. CoreDate Stack
    var modelName: String
    var sqliteName: String
    var options: NSDictionary?
    
    var description: String {
        return "context: \(managedObjectContext)\n" + "modelName: \(modelName)" +
            //        "model: \(model.entityVersionHashesByName)\n" +
            //        "coordinator: \(coordinator)\n" +
        "storeURL: \(applicationDocumentsDirectory)\n"
        //        "store: \(store)"
    }
    
    lazy var applicationDocumentsDirectory: URL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        return urls[urls.count - 1]
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: self.modelName, withExtension: "momd")!
        
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator     =   NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url             =   self.applicationDocumentsDirectory.appendingPathComponent(self.sqliteName + ".sqlite")
        var failureReason   =   "CoreData saved error"
        
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: self.options as! [AnyHashable: Any]?)
        } catch {
            var dict                                =   [String: AnyObject]()
            dict[NSLocalizedDescriptionKey]         =   "CoreData init error" as AnyObject?
            dict[NSLocalizedFailureReasonErrorKey]  =   failureReason as AnyObject?
            dict[NSUnderlyingErrorKey]              =   error as NSError
            let wrappedError                        =   NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        managedObjectContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        return managedObjectContext
    }()

    
    // MARK: - Class Initialization. Singleton
    static let instance = CoreDataManager(modelName:  "Model",
                                          sqliteName: "Model",
                                          options:    [NSMigratePersistentStoresAutomaticallyOption: true,
                                                       NSInferMappingModelAutomaticallyOption: true])
    
    private init(modelName: String, sqliteName: String, options: NSDictionary? = nil) {
        self.modelName = modelName
        self.sqliteName = sqliteName
        self.options = options
    }
    
    
    // MARK: - Class Functions
    func entityForName(_ entityName: String) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: entityName, in: self.managedObjectContext)
    }
    
    func fetchedResultsController(_ entityName: String, keyForSort: String) -> NSFetchedResultsController<NSFetchRequestResult> {
        let fetchRequest                =   NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let sortDescriptor              =   NSSortDescriptor(key: keyForSort, ascending: true)
        fetchRequest.sortDescriptors    =   [sortDescriptor]
        
        let fetchedResultsController    =   NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataManager.instance.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        return fetchedResultsController
    }

    func contextSave() {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                let nserror = error as NSError
    
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
    
    // Get Entity by name
    func entityLoad(byName name: String, andPredicateParameters predicate: NSPredicate?) -> NSManagedObject? {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult>!
        
        if (predicate == nil) {
            fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: name)
        } else {
            fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: name)
            fetchRequest.predicate = predicate
        }
        
        do {
            let results = try CoreDataManager.instance.managedObjectContext.fetch(fetchRequest)
            
            return (results.count == 0) ? self.entityCreate(byName: name) : results.first as? NSManagedObject
        } catch {
            print(error)
            
            return nil
        }
    }

    func entitiesLoad(byName name: String, andSortParameter parameter: Int) -> [NSManagedObject]? {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: name)
        var sortDescriptor = NSSortDescriptor(key: "lastName", ascending: true)
        
        sortDescriptor = NSSortDescriptor(key: "lastName", ascending: parameter == 0 ? true : false)
        fetchRequest.sortDescriptors = [sortDescriptor]

        do {
            return try CoreDataManager.instance.managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        } catch {
            print(error)
            return nil
        }
    }

    func entityBy(_ name: String, andCodeID codeID: String) -> NSManagedObject? {
        return CoreDataManager.instance.entityLoad(byName: name, andPredicateParameters: NSPredicate.init(format: "codeID = %@", codeID))
    }

    func entityCreate(byName name: String) -> NSManagedObject? {
        let newEntity = NSEntityDescription.insertNewObject(forEntityName: name, into: self.managedObjectContext)
        
        return newEntity
    }
    
    func entitiesRemove(byName name: String, andPredicateParameters predicate: NSPredicate?) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult>!

        if (predicate == nil) {
            fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: name)
        } else {
            fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: name)
            fetchRequest.predicate = predicate
        }
        
        do {
            let fetchedEntities = try self.managedObjectContext.fetch(fetchRequest)
            
            for entity in fetchedEntities {
                self.managedObjectContext.delete(entity as! NSManagedObject)
            }
        } catch {
            print(error)
        }
    }
}
