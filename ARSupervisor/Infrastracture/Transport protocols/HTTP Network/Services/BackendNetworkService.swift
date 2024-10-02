//
//  BackendNetworkService.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 01.10.2024.
//

import Foundation
import Combine

class BackendNetworkService: NetworkServiceProtocol {
    let authSession: NetworkSessionProtocol
    let session: NetworkSessionProtocol
    
    init(authSession: NetworkSessionProtocol,
         session: NetworkSessionProtocol
    ) {
        self.authSession = authSession
        self.session = session
    }
    
    func request<T>(_ requestModel: RequestModel) -> AnyPublisher<T, HTTPError> where T: Decodable {
        makeHttpHeaders(from: &requestModel.headers)
        return session.publisher(requestModel)
            .mapError{ error -> HTTPError in
                if let error = error as? HTTPError {
                    return error
                } else {
                    return HTTPError.anyError(error)
                }
            }.eraseToAnyPublisher()
    }
    
    func authRequest<T>(_ requestModel: RequestModel) -> AnyPublisher<T, HTTPError>  where T: Decodable {
        makeHttpHeaders(from: &requestModel.headers)
        return authSession.publisher(requestModel)
            .mapError { error -> HTTPError in
                if let error = error as? HTTPError {
                    return error
                } else {
                    return HTTPError.anyError(error)
                }
            }.eraseToAnyPublisher()
    }
    
    private func makeHttpHeaders(from headers: inout [String:String]?) {
        if headers == nil {
            headers =  [String:String]()
        }
        if headers?["Content-Type"] == nil {
            headers?.updateValue("application/json; charset=utf-8", forKey: "Content-Type")
        }
        headers?.updateValue("ARSupervisor.IOS", forKey: "Client")
    }
}
