//
//  SwiftDatabase.swift
//  ARSupervisor
//
//  Created by rodiewww7801_temp on 30.11.2024.
//

import Foundation
import SwiftData

@ModelActor
actor SwiftDatabase<T: PersistentModel & Sendable>: DatabaseProtocol {
    func create(_ item: T) throws {
        let context = ModelContext(self.modelContainer)
        context.insert(item)
        try context.save()
    }
    
    func create(_ items: [T]) throws {
        // need to implement batch load
        // https://www.hackingwithswift.com/quick-start/swiftdata/how-to-batch-insert-large-amounts-of-data-efficiently
        fatalError()
    }
    
    func read(predicate: Predicate<T>?,
              sortDescriptors: [SortDescriptor<T>]) throws -> [T] {
        let context = ModelContext(self.modelContainer)
        let fetchDescriptor = FetchDescriptor<T>(
            predicate: predicate,
            sortBy: sortDescriptors
        )
        return try context.fetch(fetchDescriptor)
    }
    
    func update(_ item: T) throws {
        let context = ModelContext(self.modelContainer)
        context.insert(item)
        try context.save()
    }
    
    func delete(_ item: T) throws {
        let context = ModelContext(self.modelContainer)
         let idToDelete = item.persistentModelID
         try context.delete(model: T.self, where: #Predicate { user in
             user.persistentModelID == idToDelete
         })
         try context.save()
    }
}
