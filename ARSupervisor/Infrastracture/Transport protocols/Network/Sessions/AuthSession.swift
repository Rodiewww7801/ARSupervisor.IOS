//
//  AuthSession.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 28.09.2024.
//

import Combine
import Foundation

class AuthSession: NetworkSessionProtocol {
    let session: NetworkSessionProtocol
    let tokenService: TokenServiceProtocol
    let sessionQueue: DispatchQueue = DispatchQueue(label: "auth.session.queue.\(UUID().uuidString)")
    
    init(
        session: NetworkSessionProtocol,
        tokenService: TokenServiceProtocol
    ) {
        self.session = session
        self.tokenService = tokenService
    }
    
    func publisher<T>(_ requestModel: RequestModel) -> AnyPublisher<T, any Error> where T : Decodable {
        self.addAuthHeaders(from: &requestModel.headers)
        let requestPublisher: AnyPublisher<T, any Error> = session.publisher(requestModel).eraseToAnyPublisher()
        return requestPublisher
            .catch { error -> AnyPublisher<T, any Error> in
                self.tokenService.refreshTokenPublisher()
                    .flatMap { result in
                        return requestPublisher
                    }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    func isSessionValid() -> Bool {
        self.tokenService.isTokeValid
    }
    
    func addAuthHeaders(from headers: inout [String:String]?) {
        if let accessToken = tokenService.accessToken {
            headers?.updateValue("Bearer \(accessToken)", forKey: "Authorization")
        }
    }
}
