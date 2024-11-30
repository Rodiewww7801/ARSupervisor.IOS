//
//  UserManager.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 01.10.2024.
//

actor UserManager: UserManagerProtocol {
    private let userAuthService: UserAuthServiceProtocol
    private let userDataService: UserDataServiceProtocol
    private var currentUser: User?
    
    init(userAuthService: UserAuthServiceProtocol, userDataService: UserDataServiceProtocol) {
        self.userAuthService = userAuthService
        self.userDataService = userDataService
    }
   
    func authUser(_ credentials: UserCredentials) async throws {
        let user = try await self.userAuthService.login(credentials)
        self.currentUser = user
        async let _ = saveCurrentUser()
    }
    
    func registerUser(_ credentials: UserCredentials) async throws {
        try await self.userAuthService.register(credentials)
    }
    
    func isUserSessionAlive() async -> Bool {
        let user = try? await self.getCurrentUser()
        if let user {
            let _ = try? await self.userDataService.getUserInfo(for: user.id)
            return true
        } else {
            return false
        }
    }
    
    func getCurrentUser() async throws -> User? {
        if let currentUser = self.currentUser {
            return currentUser
        } else {
            let currentUser = try await self.userDataService.getCurrentUserDB()
            guard let currentUser else { return  nil }
            self.currentUser = currentUser
            return currentUser
        }
    }
    
    private func saveCurrentUser() async throws {
        guard let user = self.currentUser else { return }
        self.currentUser = user
        try await userDataService.saveUserDB(user)
    }
}
