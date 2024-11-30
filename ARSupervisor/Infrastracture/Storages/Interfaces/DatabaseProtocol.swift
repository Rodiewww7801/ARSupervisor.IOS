//
//  DatabaseProtocol.swift
//  ARSupervisor
//
//  Created by rodiewww7801_temp on 30.11.2024.
//

import Foundation

protocol DatabaseProtocol<T>: Sendable {
    associatedtype T: Sendable
    func create(_ item: T) async throws
    func create(_ items: [T]) async throws
    func read(predicate: Predicate<T>?,
              sortDescriptors: [SortDescriptor<T>]) async throws -> [T]
    func update(_ item: T) async throws
    func delete(_ item: T) async throws
}
