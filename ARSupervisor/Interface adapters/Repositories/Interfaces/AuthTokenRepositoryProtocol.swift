//
//  AuthTokenRepositoryProtocol.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 29.09.2024.
//

protocol AuthTokenRepositoryProtocol {
    func getToken(for key: KeychainStorageKeys) -> String?
    func setToken(_ value: String, for key: KeychainStorageKeys)
    func removeToken(for key: KeychainStorageKeys)
}
