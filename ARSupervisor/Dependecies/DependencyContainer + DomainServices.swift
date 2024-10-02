//
//  DependencyContainer + DomainService.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 01.10.2024.
//

protocol DomainServiceDependency {
    func makeUserAuthService() -> UserAuthServiceProtocol
}

extension DependencyContainerProtected: DomainServiceDependency {
    func makeUserAuthService() -> UserAuthServiceProtocol {
        return UserAuthService(
            loginUserUseCase: LoginUserUseCase(
                backendService: networkDependency.networkManager.backendNetworkService,
                authTokenRepository: repositoryDependency.makeAuthTokenRepository()),
            registerUserUseCase: RegisterUserUseCase(backendService: networkDependency.networkManager.backendNetworkService)
        )
    }
}
