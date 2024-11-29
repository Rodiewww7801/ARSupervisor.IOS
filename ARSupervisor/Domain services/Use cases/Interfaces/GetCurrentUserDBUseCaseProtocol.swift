//
//  GetCurrentUserDBUseCaseProtocol.swift
//  ARSupervisor
//
//  Created by rodiewww7801_temp on 28.11.2024.
//

protocol GetCurrentUserDBUseCaseProtocol {
    func execute() async throws -> UserInfoDTO
}

