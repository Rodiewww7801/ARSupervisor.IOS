//
//  NetworkManager.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 28.09.2024.
//

import Combine

class NetworkManager: NetworkManagerProtocol {
    var backendNetworkService: NetworkServiceProtocol
    
    init(backendNetworkService: NetworkServiceProtocol) {
        self.backendNetworkService = backendNetworkService
    }
}
