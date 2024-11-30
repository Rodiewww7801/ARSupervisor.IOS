//
//  UserDataRepositoryProtocol.swift
//  ARSupervisor
//
//  Created by rodiewww7801_temp on 29.11.2024.
//

import SwiftData

protocol UserDataRepositoryProtocol: Sendable {
    func getCurrentUser() async throws -> UserInfoDTO?
    func saveUser(_ user: UserInfoDTO) async throws
}
