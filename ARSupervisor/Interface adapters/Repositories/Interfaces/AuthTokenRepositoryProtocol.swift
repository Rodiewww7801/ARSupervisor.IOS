//
//  AuthTokenRepositoryProtocol.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 29.09.2024.
//

protocol AuthTokenRepositoryProtocol: Sendable {
    func getToken(for key: KeychainStorageKeys) async -> String?
    func setToken(_ value: String, for key: KeychainStorageKeys) async
    func removeToken(for key: KeychainStorageKeys) async
}
