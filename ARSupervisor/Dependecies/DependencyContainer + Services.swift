//
//  DependencyContainer + Services.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 01.10.2024.
//

extension DependencyContainer {
    func makeServiceFactory() -> ServicesFactoryProtocol {
        return ServicesFactory()
    }
}
