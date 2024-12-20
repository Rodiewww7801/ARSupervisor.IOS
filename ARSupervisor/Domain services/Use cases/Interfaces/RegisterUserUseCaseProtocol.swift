//
//  RegisterUserUseCaseProtocol.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 01.10.2024.
//

protocol RegisterUserUseCaseProtocol: Sendable {
    func execute(_ dto: RegisterRequestDTO) async throws 
}
