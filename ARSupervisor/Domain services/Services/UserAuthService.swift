//
//  UserAuthService.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 01.10.2024.
//


final class UserAuthService: UserAuthServiceProtocol {
    private let loginUserUseCase: LoginUserUseCaseProtocol
    private let registerUserUseCase: RegisterUserUseCaseProtocol
    
    init(loginUserUseCase: LoginUserUseCaseProtocol, registerUserUseCase: RegisterUserUseCaseProtocol) {
        self.loginUserUseCase = loginUserUseCase
        self.registerUserUseCase = registerUserUseCase
    }
    
    func login(_ credentials: UserCredentials) async throws -> User {
        let requestDTO = LoginRequestDTO(email: credentials.email, password: credentials.password)
        let responseDTO =  try await loginUserUseCase.execute(requestDTO)
        let user = await Task { @UserManagerActor in
            return User(id: responseDTO.userId)
        }.value
        return user
    }
    
    func register(_ credentials: UserCredentials) async throws {
        let dto = RegisterRequestDTO(email: credentials.email, password: credentials.password)
        return try await registerUserUseCase.execute(dto)
    }
}
