//
//  UserManagerProtocol.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 01.10.2024.
//

@globalActor actor UserManagerActor {
    static let shared = UserManagerActor()
}

protocol UserManagerProtocol: Sendable {
    func authUser(_ credentials: UserCredentials) async throws
    func registerUser(_ credentials: UserCredentials) async throws
    func isUserSessionAlive() async -> Bool
    func getCurrentUser() async throws -> User?
}
