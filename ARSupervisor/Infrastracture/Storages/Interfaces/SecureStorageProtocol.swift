//
//  SecureStorageProtocol.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 29.09.2024.
//

protocol SecureStorageProtocol {
    func setValue(_ value: String, for userAccount: String) throws
    func getValue(for userAccount: String) throws -> String?
    func removeValue(for userAccount: String) throws
    func removeAllValues() throws
}
