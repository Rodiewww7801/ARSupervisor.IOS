//
//  DependencyContainer + DomainService.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 01.10.2024.
//

protocol DomainServiceDependency {
    func makeUserAuthService() -> UserAuthServiceProtocol
    func makeUserDataService() -> UserDataServiceProtocol
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
    
    func makeUserDataService() -> UserDataServiceProtocol {
        return UserDataService(
            getUserInfoUseCase: GetUserInfoUseCase(backendService: networkDependency.networkManager.backendNetworkService),
            getCurrentUserDBUseCase: GetCurrentUserDBUseCase(userDataRepository: repositoryDependency.makeUserDataRepository()),
            saveUserDBUseCase: SaveUserDBUseCase(userDataRepository: repositoryDependency.makeUserDataRepository()))
    }
}
