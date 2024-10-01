//
//  UserAuthService.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 01.10.2024.
//

import Combine

class UserAuthService: UserAuthServiceProtocol {
    private let loginUserUseCase: LoginUserUseCaseProtocol
    
    init(loginUserUseCase: LoginUserUseCaseProtocol) {
        self.loginUserUseCase = loginUserUseCase
    }
    
    func login(user: User) -> AnyPublisher<Void, any Error> {
        let dto = LoginRequestDTO(email: user.credentials.email, passwrod: user.credentials.password)
        return loginUserUseCase.execute(dto)
    }
    
    func register(user: User) -> AnyPublisher<Void, any Error> {
        fatalError()
    }
    
    func logout() -> AnyPublisher<Void, any Error> {
        fatalError()
    }
}
