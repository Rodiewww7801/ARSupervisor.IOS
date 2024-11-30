//
//  UserAuthServiceProtocol.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 01.10.2024.
//

protocol UserAuthServiceProtocol: Sendable {
    func login(_ credentials: UserCredentials) async throws -> User
    func register(_ credentials: UserCredentials) async throws
}
