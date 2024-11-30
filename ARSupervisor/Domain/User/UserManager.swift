//
//  UserManager.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 01.10.2024.
//

//todo: remove unsafe
class UserManager: UserManagerProtocol, @unchecked Sendable {
    private let userAuthService: UserAuthServiceProtocol
    private let userDataService: UserDataServiceProtocol
    private var currentUser: User?
    
    init(userAuthService: UserAuthServiceProtocol, userDataService: UserDataServiceProtocol) {
        self.userAuthService = userAuthService
        self.userDataService = userDataService
    }
    
    func authUser(_ credentials: UserCredentials) async throws {
        let user = try await self.userAuthService.login(credentials)
        async let _ = try setCurrentUser(user)
    }
    
    func registerUser(_ credentials: UserCredentials) async throws {
        try await self.userAuthService.register(credentials)
    }
    
    func isUserSessionAlive() async -> Bool {
        do {
            let user = try await self.getCurrentUser()
            let _ = try await self.userDataService.getUserInfo(for: user.id)
            return true
        } catch {
            return false
        }
    }
    
    func getCurrentUser() async throws -> User {
        if let currentUser {
            return currentUser
        } else {
            let currentUser = try await self.userDataService.getCurrentUserDB()
            self.currentUser = currentUser
            return currentUser
        }
    }
    
    private func setCurrentUser(_ user: User) async throws {
        self.currentUser = user
        try await userDataService.saveUserDB(user)
    }
}
