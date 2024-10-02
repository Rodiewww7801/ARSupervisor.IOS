//
//  UserManager.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 01.10.2024.
//

import Combine

class UserManager: UserManagerProtocol {
    private let userAuthService: UserAuthServiceProtocol
    
    init(userAuthService: UserAuthServiceProtocol) {
        self.userAuthService = userAuthService
    }
    
    func authUser(_ credentials: UserCredentials) -> AnyPublisher<Void, ARSAuthError> {
        self.userAuthService.login(credentials)
    }
    
    func registerUser(_ user: User) -> AnyPublisher<Void, ARSAuthError> {
        self.userAuthService.register(user)
    }
}
