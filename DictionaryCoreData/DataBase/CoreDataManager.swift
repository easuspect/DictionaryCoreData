//
//  CoreDataManager.swift
//  DictionaryCoreData
//
//  Created by NewMac on 11/7/22.
//


//update view controller sayfasi yapilacak.

import CoreData
import UIKit

protocol DatabaseProtocol {
    func fetch() -> [Word]
    func insert(name: String, meaning: String) -> Word
    func delete(word: Word)
    func update(word: Word)
}

class CoreDataManager: DatabaseProtocol {
    
    private let modelName: String
    
    init(modelName: String) {
        self.modelName = modelName
        setupNotificationHandling()
    }
 
    private lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer.init(name: modelName)
        container.loadPersistentStores { description, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    func fetch() -> [Word] {
        let request = NSFetchRequest<Word>.init(entityName: "Word")
        var result: [Word] = []
        
        do {
            result = try container.viewContext.fetch(request)
        } catch {
            print(error)
        }
        return result
    }
    
    func insert(name: String, meaning: String) -> Word {
        let word = Word.init(context: container.viewContext)
        word.name = name
        word.meaning = meaning
        return word
    }
    
    func delete(word: Word) {
        container.viewContext.delete(word)
    }
    
    func update(word: Word) {
        let word = Word.init(context: container.viewContext)
        if word.name == word.meaning {
            return
        } else {
            update(word: word)
        }
    }
}

private extension CoreDataManager {
    func setupNotificationHandling() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self,
                                       selector: #selector(saveChanges),
                                       name: UIApplication.willTerminateNotification,
                                       object: nil)
        notificationCenter.addObserver(self,
                                       selector: #selector(saveChanges),
                                       name: UIApplication.didEnterBackgroundNotification,
                                       object: nil)
    }
    
    @objc
    func saveChanges() {
        container.viewContext.perform {
            do {
                if self.container.viewContext.hasChanges {
                    try self.container.viewContext.save()
                }
            } catch {
                print("Unable to Save Changes of Managed Object Context")
                print("\(error), \(error.localizedDescription)")
            }
        }
    }
}
