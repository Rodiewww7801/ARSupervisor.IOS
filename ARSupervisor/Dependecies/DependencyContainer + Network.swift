//
//  DependencyContainer + Network.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 28.09.2024.
//

import Foundation

protocol NetworkDependency {
    var networkManager: NetworkManagerProtocol { get }
    func makeRequestBuilder() -> RequestBuilderProtocol
}

extension DependencyContainerProtected: NetworkDependency {
    var networkManager: NetworkManagerProtocol {
        if let _networkManager {
            return _networkManager
        }
        
        _networkManager = self.makeNetworkManager()
        return _networkManager
    }
    
    func makeRequestBuilder() -> RequestBuilderProtocol {
        return RequestBuilder()
    }
    
    private func makeBackendNetworkService() -> NetworkServiceProtocol {
        let authTokenRepository = repositoryDependency.makeAuthTokenRepository()
        let defaultSession = DefaultSession()
        let tokenService = TokenService(session: defaultSession, authTokenRepository: authTokenRepository)
        let authSession = AuthSession(session: defaultSession, tokenService: tokenService)
        let backendNetwrokService = BackendNetworkService(authSession: authSession, session: defaultSession)
        return backendNetwrokService
    }
    
    private func makeNetworkManager() -> NetworkManagerProtocol {
        let netwrokService = makeBackendNetworkService()
        let manager = NetworkManager(backendNetworkService: netwrokService)
        return manager
    }
}
