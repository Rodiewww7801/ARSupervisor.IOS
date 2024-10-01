//
//  NetworkFactoryProtocol.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 28.09.2024.
//

import Foundation

protocol NetworkFactoryProtocol {
    func makeNetworkManager() -> NetworkManagerProtocol
    func makeRequestBuilder() -> RequestBuilderProtocol
}
