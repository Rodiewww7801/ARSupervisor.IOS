//
//  TokenServiceProtocol.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 29.09.2024.
//

protocol TokenServiceProtocol: Sendable {
    typealias EncodedToken = String
    
    func accessToken() async -> EncodedToken?
    func refreshToken() async -> EncodedToken?
    func isTokeValid() async -> Bool
    
    func refreshTokenPublisher() async throws
    func decodeToken(_ token: EncodedToken) async throws -> Token
}
