//
//  LoginUserUseCaseProtocol.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 01.10.2024.
//

protocol LoginUserUseCaseProtocol: Sendable {
    func execute(_ parameters: LoginRequestDTO) async throws -> LoginResponseDTO
}
