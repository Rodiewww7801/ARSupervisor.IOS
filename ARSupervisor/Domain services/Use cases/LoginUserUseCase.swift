//
//  LoginUserUseCase.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 01.10.2024.
//

import Combine

class LoginUserUseCase: LoginUserUseCaseProtocol {
    private let backendService: NetworkServiceProtocol
    private let authTokenRepository: AuthTokenRepositoryProtocol
    
    init(backendService: NetworkServiceProtocol,
         authTokenRepository: AuthTokenRepositoryProtocol) {
        self.backendService = backendService
        self.authTokenRepository = authTokenRepository
    }
    
    func execute(_ dto: LoginRequestDTO) -> AnyPublisher<Void, any Error> {
        let requestModel = BackendAPIRequestFactory.login(with: dto)
        let publisher: AnyPublisher<TokensResponseDTO, any Error> = backendService.request(requestModel)
        return publisher
            .flatMap { dto -> AnyPublisher<Void, any Error> in
                Future<Void, any Error> { promise in
                    self.authTokenRepository.setToken(dto.accessToken, for: .accessTokenKey)
                    self.authTokenRepository.setToken(dto.refreshToken, for: .accessTokenKey)
                    promise(.success( Void() ))
                }.eraseToAnyPublisher()
            }.eraseToAnyPublisher()
    }
}
