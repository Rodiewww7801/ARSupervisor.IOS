//
//  AuthTokenRepository.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 29.09.2024.
//

import Foundation

class AuthTokenRepository: AuthTokenRepositoryProtocol {
    private let securedStorage: SecureStorageProtocol
    
    init(securedStorage: SecureStorageProtocol) {
        self.securedStorage = securedStorage
    }
    
    func getToken(for key: KeychainStorageKeys) -> String? {
        do {
            let token = try securedStorage.getValue(for: key.rawValue)
            return token
        } catch {
            Logger.log(.error, "\(error)")
        }
        return nil
    }
    
    func setToken(_ value: String, for key: KeychainStorageKeys) {
        do {
            try securedStorage.setValue(value, for: key.rawValue)
        } catch {
            Logger.log(.error, "\(error)")
        }
    }
    
    func removeToken(for key: KeychainStorageKeys) {
        do {
            try securedStorage.removeValue(for: key.rawValue)
        } catch {
            Logger.log(.error, "\(error)")
        }
    }
}
