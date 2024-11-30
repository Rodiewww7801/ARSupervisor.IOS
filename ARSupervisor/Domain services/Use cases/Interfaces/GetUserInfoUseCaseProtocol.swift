//
//  GetUserInfoUseCaseProtocol.swift
//  ARSupervisor
//
//  Created by rodiewww7801_temp on 27.11.2024.
//

protocol GetUserInfoUseCaseProtocol: Sendable {
    func execute(_ userId: String) async throws -> UserInfoDTO
}
