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
    
    func execute(_ dto: LoginRequestDTO) -> AnyPublisher<Void, ARSAuthError> {
        let requestModel = BackendAPIRequestFactory.login(with: dto)
        let publisher: AnyPublisher<TokensResponseDTO, HTTPError> = backendService.request(requestModel)
        return publisher
            .mapError { error -> ARSAuthError in
                return ARSAuthError.UserAuthenticationError(message: error.customDescription)
            }
            .flatMap { dto -> Future<Void, ARSAuthError> in
                Future<Void, ARSAuthError> { promise in
                    self.authTokenRepository.setToken(dto.accessToken, for: .accessTokenKey)
                    self.authTokenRepository.setToken(dto.refreshToken, for: .accessTokenKey)
                    promise(.success( Void() ))
                }
            }.eraseToAnyPublisher()
    }
}
