//
//  TokenServiceProtocol.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 29.09.2024.
//

protocol TokenServiceProtocol {
    typealias EncodedToken = String
    
    var accessToken: EncodedToken? { get }
    var refreshToken: EncodedToken? { get }
    var isTokeValid: Bool { get }
    
    func refreshTokenPublisher() async throws
    func decodeToken(_ token: EncodedToken) throws -> Token
}
