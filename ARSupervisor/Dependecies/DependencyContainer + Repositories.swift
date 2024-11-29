//
//  DependencyContainer + Repositories.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 01.10.2024.
//

import SwiftData

protocol RepositoryDependency {
    func makeAuthTokenRepository() -> AuthTokenRepositoryProtocol
    func makeUserDataRepository() -> UserDataRepositoryProtocol
}

extension DependencyContainerProtected: RepositoryDependency  {
    func makeAuthTokenRepository() -> AuthTokenRepositoryProtocol {
        return AuthTokenRepository(securedStorage: storageDependency.keychainStorage)
    }
    
    func makeUserDataRepository() -> UserDataRepositoryProtocol {
        //TODO: refactor try
        return UserDataRepository(modelContainer: try! ModelContainer(for: SDUser.self))
    }
}
