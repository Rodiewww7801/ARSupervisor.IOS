//
//  DependencyContainer + Network.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 28.09.2024.
//

extension DependencyContainerProtected {
    var networkManager: NetworkManagerProtocol {
        if let _networkManager {
            return _networkManager
        }
        
        _networkManager = networkFactory.makeNetworkManager()
        return _networkManager
    }
}

extension DependencyContainer {
    var networkFactory: NetworkFactoryProtocol {
        return NetworkFactory()
    }
}
