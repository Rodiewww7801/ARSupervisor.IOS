//
//  NetworkServiceFactory.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 28.09.2024.
//

import Foundation

class NetworkFactory: NetworkFactoryProtocol {
    func makeRequestBuilder() -> RequestBuilderProtocol {
        return RequestBuilder()
    }
    
    private func makeBackendNetworkService() -> NetworkServiceProtocol {
        let authTokenRepository = dependency.repositoryFactory().makeAuthTokenRepository()
        let tokenService = TokenService(session: URLSession.shared, authTokenRepository: authTokenRepository)
        let authSession = AuthSession(session: URLSession.shared, tokenService: tokenService)
        let backendNetwrokService = BackendNetwrokService(authSession: authSession, session: URLSession.shared)
        return backendNetwrokService
    }
    
    func makeNetworkManager() -> NetworkManagerProtocol {
        let netwrokService = makeBackendNetworkService()
        let manager = NetworkManager(backendNetworkService: netwrokService)
        return manager
    }
}
