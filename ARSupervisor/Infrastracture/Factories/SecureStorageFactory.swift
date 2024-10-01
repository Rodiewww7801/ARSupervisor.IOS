//
//  SecureStorageFactory.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 29.09.2024.
//

class SecureStorageFactory: SecureStorageFactoryProtocol {
    func makeSecureStorage() -> SecureStorageProtocol {
        let keychainStorage = KeychainStorage(secureStorageQueryable: GenericPasswordQueryable(service: "AuthenticationTokenService"))
        return keychainStorage
    }
}
