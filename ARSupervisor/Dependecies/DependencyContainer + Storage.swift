//
//  DependencyContainer + Storage.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 29.09.2024.
//

extension DependencyContainerProtected {
    var secureStorageFactory: SecureStorageFactoryProtocol {
        return SecureStorageFactory()
    }
    
    var keychainStorage: SecureStorageProtocol {
        if let _keychainStorage {
            return _keychainStorage
        }
        
        _keychainStorage = secureStorageFactory.makeSecureStorage()
        return _keychainStorage
    }
}
