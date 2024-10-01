//
//  DependencyContainer + Repositories.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 01.10.2024.
//

protocol RepositoryDependency {
    func makeAuthTokenRepository() -> AuthTokenRepositoryProtocol
}

extension DependencyContainerProtected: RepositoryDependency  {
    func makeAuthTokenRepository() -> AuthTokenRepositoryProtocol {
        return AuthTokenRepository(securedStorage: storageDependency.keychainStorage)
    }
}
