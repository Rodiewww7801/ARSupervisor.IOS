//
//  KeychainStorage.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 29.09.2024.
//

import Foundation

enum KeychainStorageKeys: String {
    case accessTokenKey = "AccessTokenKey"
    case refreshTokenKey = "RefreshTokenKey"
}

struct KeychainStorage: SecureStorageProtocol {
    let secureStorageQueryable: SecureStorageQueryable
    
    init(secureStorageQueryable: SecureStorageQueryable) {
        self.secureStorageQueryable = secureStorageQueryable
    }
    
    func setValue(_ value: String, for key: String) throws {
        guard let encodedPassword = value.data(using: .utf8) else {
            throw SecureStorageError.conversionError
        }
        
        var query = secureStorageQueryable.query
        query[String(kSecAttrService)] = key
        
        var status = SecItemCopyMatching(query as CFDictionary, nil)
        switch status {
        case errSecSuccess:
            var attributesToUpdate: [String: Any] = [:]
            attributesToUpdate[String(kSecValueData)] = encodedPassword
            
            status = SecItemUpdate(query as CFDictionary,
                                   attributesToUpdate as CFDictionary)
            if status != errSecSuccess {
                throw error(from: status)
            }
        case errSecItemNotFound:
            query[String(kSecValueData)] = encodedPassword
            
            status = SecItemAdd(query as CFDictionary, nil)
            if status != errSecSuccess {
                throw error(from: status)
            }
        default:
            throw error(from: status)
        }
    }
    
    func getValue(for key: String) throws -> String? {
        var query = secureStorageQueryable.query
        query[String(kSecMatchLimit)] = kSecMatchLimitOne
        query[String(kSecReturnAttributes)] = kCFBooleanTrue
        query[String(kSecReturnData)] = kCFBooleanTrue
        query[String(kSecAttrService)] = key
        
        var queryResult: AnyObject?
        let status = withUnsafeMutablePointer(to: &queryResult) {
            SecItemCopyMatching(query as CFDictionary, $0)
        }
        
        switch status {
        case errSecSuccess:
            guard
                let queriedItem = queryResult as? [String: Any],
                let passwordData = queriedItem[String(kSecValueData)] as? Data,
                let password = String(data: passwordData, encoding: .utf8)
            else {
                throw SecureStorageError.conversionError
            }
            return password
        case errSecItemNotFound:
            return nil
        default:
            throw error(from: status)
        }
    }
    
    func removeValue(for key: String) throws {
        var query = secureStorageQueryable.query
        query[String(kSecAttrService)] = key
        
        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw error(from: status)
        }
    }
    
    func removeAllValues() throws {
        let query = secureStorageQueryable.query
        
        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw error(from: status)
        }
    }
    
    private func error(from status: OSStatus) -> SecureStorageError {
        let message = SecCopyErrorMessageString(status, nil) as String? ?? NSLocalizedString("Unhandled Error", comment: "")
        return SecureStorageError.unhandledError(message: message)
    }
}
