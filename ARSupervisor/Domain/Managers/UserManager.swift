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
    
    func authUser(_ user: User) -> AnyPublisher<Void, any Error> {
        self.userAuthService.login(user: user)
    }
}
