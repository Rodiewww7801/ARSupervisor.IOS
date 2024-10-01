//
//  DependencyContainer + Storage.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 29.09.2024.
//

protocol StorageDependency {
    var keychainStorage: SecureStorageProtocol { get }
}

extension DependencyContainerProtected: StorageDependency {
    var keychainStorage: SecureStorageProtocol {
        if let _keychainStorage {
            return _keychainStorage
        }
        
        _keychainStorage = makeKeychainStorage()
        return _keychainStorage
    }
    
    private func makeKeychainStorage() -> SecureStorageProtocol {
        let keychainStorage = KeychainStorage(secureStorageQueryable: GenericPasswordQueryable(service: "AuthenticationTokenService"))
        return keychainStorage
    }
}
