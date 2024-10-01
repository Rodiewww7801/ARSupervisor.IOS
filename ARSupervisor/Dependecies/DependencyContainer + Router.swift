//
//  DependencyContainer + Router.swift
//  AugmentedRealitySupervisorIOS
//
//  Created by Rodion Hladchenko on 05.09.2024.
//

protocol RouterDependency {
    var routerFactory: RouterFactoryProtocol { get }
}

extension DependencyContainerProtected: RouterDependency {
    var routerFactory: RouterFactoryProtocol {
        return RouterFactory()
    }
}
