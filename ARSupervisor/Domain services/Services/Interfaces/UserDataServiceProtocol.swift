//
//  UserDataServiceProtocol.swift
//  ARSupervisor
//
//  Created by rodiewww7801_temp on 28.11.2024.
//

protocol UserDataServiceProtocol: Sendable {
    func getUserInfo(for userId: String) async throws -> UserInfo
    func getCurrentUserDB() async throws -> User?
    func saveUserDB(_ user: User) async throws
}
