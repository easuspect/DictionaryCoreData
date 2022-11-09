//
//  CoreDataManager.swift
//  DictionaryCoreData
//
//  Created by NewMac on 11/7/22.
//

import CoreData

class CoreDataManager {
    
    private let modelName: String
    
    init(modelName: String) {
        self.modelName = modelName
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
}
