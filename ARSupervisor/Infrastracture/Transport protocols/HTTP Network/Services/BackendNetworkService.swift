//
//  BackendNetworkService.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 01.10.2024.
//

import Foundation
import Combine

class BackendNetworkService: NetworkServiceProtocol {
    let authSession: AuthSession
    let session: URLSession
    
    init(authSession: AuthSession, session: URLSession) {
        self.authSession = authSession
        self.session = session
    }
    
    func request<T>(_ requestModel: RequestModel) -> AnyPublisher<T, any Error> where T : Decodable {
        return session.publisher(requestModel)
    }
    
    func authRequest<T>(_ requestModel: RequestModel) -> AnyPublisher<T, any Error> where T : Decodable {
        return authSession.publisher(requestModel)
    }
}
