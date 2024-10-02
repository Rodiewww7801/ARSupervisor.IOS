//
//  TokenServiceProtocol.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 29.09.2024.
//

import Combine

protocol TokenServiceProtocol {
    typealias EncodedToken = String
    
    var accessToken: EncodedToken? { get }
    var refreshToken: EncodedToken? { get }
    var isTokeValid: Bool { get }
    
    func refreshTokenPublisher() -> AnyPublisher<Void, ARSAuthError>
    func decodeToken(_ token: EncodedToken) throws -> Token
}
