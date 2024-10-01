//
//  DependencyContainer + Repositories.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 01.10.2024.
//

extension DependencyContainer {
    func repositoryFactory() -> RepositoryFactoryProtocol {
        return RepositoryFactory()
    }
}
