//
//  RepositoryFactory.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 01.10.2024.
//

class RepositoryFactory: RepositoryFactoryProtocol {
    func makeAuthTokenRepository() -> AuthTokenRepositoryProtocol {
        return AuthTokenRepository(securedStorage: dependency.keychainStorage)
    }
}
