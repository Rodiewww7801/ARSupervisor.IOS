//
//  SwiftDatabaseFactory.swift
//  ARSupervisor
//
//  Created by rodiewww7801_temp on 30.11.2024.
//

import SwiftData

class SwiftDatabaseFactory {
    private let configuration: ModelConfiguration? = nil
    
    func factory<T: PersistentModel>(for type: T.Type) throws -> SwiftDatabase<T> {
        let container: ModelContainer
        if let configuration {
            container = try ModelContainer(for: type, configurations: configuration)
        } else {
            container = try ModelContainer(for: type)
        }
        return SwiftDatabase(modelContainer: container)
    }
}
