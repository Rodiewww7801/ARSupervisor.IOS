//
//  DependencyContainer + NavigationController.swift
//  AugmentedRealitySupervisorIOS
//
//  Created by Rodion Hladchenko on 06.09.2024.
//

protocol NavigationContrllerDependency {
    var navigationControllerFactory: NavigationControllerFactoryProtocol { get }
}

extension DependencyContainerProtected: NavigationContrllerDependency {
    var navigationControllerFactory: NavigationControllerFactoryProtocol {
        return NavigationControllerFactory()
    }
}
