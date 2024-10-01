//
//  DependencyContainer + NavigationController.swift
//  AugmentedRealitySupervisorIOS
//
//  Created by Rodion Hladchenko on 06.09.2024.
//

extension DependencyContainer {
    var navigationControllerFactory: NavigationControllerFactoryProtocol {
        return NavigationControllerFactory()
    }
}
