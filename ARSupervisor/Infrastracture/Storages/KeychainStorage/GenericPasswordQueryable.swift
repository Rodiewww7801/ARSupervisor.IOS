//
//  GenericPasswordQueryable.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 29.09.2024.
//

import Foundation

public protocol SecureStorageQueryable {
    var query: [String: Any] { get }
}

public struct GenericPasswordQueryable {
    let service: String
    let accessGroup: String?
    
    init(service: String, accessGroup: String? = nil) {
        self.service = service
        self.accessGroup = accessGroup
    }
}

extension GenericPasswordQueryable: SecureStorageQueryable {
    public var query: [String: Any] {
        var query: [String: Any] = [:]
        query[String(kSecClass)] = kSecClassGenericPassword
        query[String(kSecAttrService)] = service
        // Access group if target environment is not simulator
        #if !targetEnvironment(simulator)
        if let accessGroup = accessGroup {
            query[String(kSecAttrAccessGroup)] = accessGroup
        }
        #endif
        return query
    }
}
