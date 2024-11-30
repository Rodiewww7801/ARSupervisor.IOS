//
//  SaveUserDBUseCaseProtocol.swift
//  ARSupervisor
//
//  Created by rodiewww7801_temp on 28.11.2024.
//

protocol SaveUserDBUseCaseProtocol: Sendable {
    func execute(_ user: UserInfoDTO) async throws
}
