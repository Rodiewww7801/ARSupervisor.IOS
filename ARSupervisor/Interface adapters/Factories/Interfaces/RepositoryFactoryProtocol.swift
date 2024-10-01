//
//  RepositoryFactoryProtocol.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 01.10.2024.
//

protocol RepositoryFactoryProtocol {
    func makeAuthTokenRepository() -> AuthTokenRepositoryProtocol
}
