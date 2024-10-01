//
//  DependencyContainer.swift
//  AugmentedRealitySupervisorIOS
//
//  Created by Rodion Hladchenko on 03.09.2024.
//

import Foundation

/// `DependencyContainer` is used for resolving dependencies.
///
/// It implements the Dependency Injection (DI) software design pattern, which is a part of Inversion of Control (IoC).
/// `DependencyContainer` helps the app by splitting it into loosely-coupled components, making testing and maintenance easier.
/// In `DependencyContainer`, components can be easily developed due to the substitution of protocol implementations.

protocol DependencyContainer {
    static var shared: DependencyContainer { get }
    
    var networkDependency: NetworkDependency { get }
    var repositoryDependency: RepositoryDependency { get }
    var storageDependency: StorageDependency { get }
    var routerDependency: RouterDependency { get }
    var navigationContrllerDependency: NavigationContrllerDependency { get }
    var coordinatorDependency: CoordinatorDependency { get }
}

// protected because it incapsulate private property for inheritance
class DependencyContainerProtected: DependencyContainer {
    static let shared: DependencyContainer = DependencyContainerProtected()
    
    // MARK: - Private properties but accessable for inheritens
    var _networkManager: NetworkManagerProtocol!
    var _keychainStorage: SecureStorageProtocol!
    
    // MARK: - Namespacing for dependency
    var networkDependency: NetworkDependency { self }
    var repositoryDependency: RepositoryDependency { self }
    var storageDependency: StorageDependency { self }
    var routerDependency: RouterDependency { self }
    var navigationContrllerDependency: NavigationContrllerDependency { self }
    var coordinatorDependency: CoordinatorDependency { self }
}
