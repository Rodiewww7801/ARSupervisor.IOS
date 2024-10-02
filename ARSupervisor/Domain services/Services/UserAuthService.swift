//
//  UserAuthService.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 01.10.2024.
//

import Combine

class UserAuthService: UserAuthServiceProtocol {
    private let loginUserUseCase: LoginUserUseCaseProtocol
    private let registerUserUseCase: RegisterUserUseCaseProtocol
    
    init(loginUserUseCase: LoginUserUseCaseProtocol, registerUserUseCase: RegisterUserUseCaseProtocol) {
        self.loginUserUseCase = loginUserUseCase
        self.registerUserUseCase = registerUserUseCase
    }
    
    func login(_ credentials: UserCredentials) -> AnyPublisher<Void, ARSAuthError> {
        let dto = LoginRequestDTO(email: credentials.email, password: credentials.password)
        return loginUserUseCase.execute(dto)
    }
    
    func register(_ user: User) -> AnyPublisher<Void, ARSAuthError> {
        let dto = RegisterRequestDTO(email: user.credentials.email, password: user.credentials.password)
        return registerUserUseCase.execute(dto)
    }
    
    func logout() -> AnyPublisher<Void, any Error> {
        fatalError()
    }
}
