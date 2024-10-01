//
//  ServicesFactoryProtocol.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 01.10.2024.
//

protocol ServicesFactoryProtocol {
    func makeUserAuthService() -> UserAuthServiceProtocol
}
