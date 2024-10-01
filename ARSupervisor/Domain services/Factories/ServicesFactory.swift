//
//  ServicesFactory.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 01.10.2024.
//

class ServicesFactory: ServicesFactoryProtocol {
    func makeUserAuthService() -> any UserAuthServiceProtocol {
        return UserAuthService(
            loginUserUseCase: LoginUserUseCase(
                backendService: dependency.networkManager.backendNetworkService,
                authTokenRepository: dependency.repositoryFactory().makeAuthTokenRepository()))
    }
}
