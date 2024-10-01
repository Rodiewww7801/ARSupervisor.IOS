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


class DependencyContainerProtected: DependencyContainer {
    static let shared: DependencyContainer = DependencyContainerProtected()
    
    // MARK: - Singletons
    var _networkManager: NetworkManagerProtocol!
    var _keychainStorage: SecureStorageProtocol!
}

protocol DependencyContainer {
    static var shared: DependencyContainer { get }
    var networkManager: NetworkManagerProtocol { get }
    var keychainStorage: SecureStorageProtocol { get }
}
