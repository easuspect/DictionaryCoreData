//
//  Word.swift
//  DictionaryCoreData
//
//  Created by NewMac on 11/7/22.
//

import Foundation
import CoreData

@objc(Word)
class Word: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var meaning: String
}
