//
//  NetworkManagerProtocol.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 29.09.2024.
//

import Combine

protocol NetworkManagerProtocol {
    var backendNetworkService: NetworkServiceProtocol { get }
}
