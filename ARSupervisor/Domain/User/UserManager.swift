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
   
    @UserManagerActor
    func authUser(_ credentials: UserCredentials) async throws {
        let dto = try await self.userAuthService.login(credentials)
        let user = User(id: dto.userId)
        try await setCurrentUser(user)
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
    
    @UserManagerActor
    func getCurrentUser() async throws -> User? {
        if let currentUser = await self.currentUser {
            return currentUser
        } else {
            let dto = try await self.userDataService.getCurrentUserDB()
            guard let dto else { return  nil }
            let currentUser = User(id: dto.id)
            currentUser.info = dto.toModel()
            try await setCurrentUser(currentUser)
            return currentUser
        }
    }
    
    private func setCurrentUser(_ user: User) async throws {
        self.currentUser = user
    }
    
    private func saveCurrentUser() async throws {
        guard let user = self.currentUser else { return }
        self.currentUser = user
        try await userDataService.saveUserDB(user)
    }
}
