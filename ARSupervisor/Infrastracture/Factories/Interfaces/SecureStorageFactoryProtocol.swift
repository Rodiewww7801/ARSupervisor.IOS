//
//  SecureStorageFactoryProtocol.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 29.09.2024.
//

protocol SecureStorageFactoryProtocol {
    func makeSecureStorage() -> SecureStorageProtocol
}
