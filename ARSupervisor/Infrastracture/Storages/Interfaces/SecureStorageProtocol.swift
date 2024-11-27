//
//  SecureStorageProtocol.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 29.09.2024.
//

protocol SecureStorageProtocol {
    func setValue(_ value: String, for key: String) throws
    func getValue(for key: String) throws -> String?
    func removeValue(for key: String) throws
    func removeAllValues() throws
}
