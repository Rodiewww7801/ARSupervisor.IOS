//
//  DependencyContainer + Coordinator.swift
//  AugmentedRealitySupervisorIOS
//
//  Created by Rodion Hladchenko on 05.09.2024.
//

protocol CoordinatorDependency {
    var coordinatorFactory: CoordinatorFactoryProtocol { get }
}

extension DependencyContainerProtected: CoordinatorDependency {    
    var coordinatorFactory: CoordinatorFactoryProtocol {
        return CoordinatorFactory()
    }
}
