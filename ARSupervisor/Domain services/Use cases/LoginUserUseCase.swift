//
//  LoginUserUseCase.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 01.10.2024.
//

class LoginUserUseCase: LoginUserUseCaseProtocol {
    private let backendService: NetworkServiceProtocol
    private let authTokenRepository: AuthTokenRepositoryProtocol
    
    init(backendService: NetworkServiceProtocol,
         authTokenRepository: AuthTokenRepositoryProtocol) {
        self.backendService = backendService
        self.authTokenRepository = authTokenRepository
    }
    
    func execute(_ dto: LoginRequestDTO) async throws -> LoginResponseDTO {
        let requestModel = BackendAPIRequestFactory.login(with: dto)
        do {
            let dto: LoginResponseDTO = try await backendService.request(requestModel)
            self.authTokenRepository.setToken(dto.accessToken, for: .accessTokenKey)
            self.authTokenRepository.setToken(dto.refreshToken, for: .accessTokenKey)
            return dto
        } catch let error as HTTPError {
            throw ARSAuthError.UserAuthenticationError(message: error.customDescription)
        }
    }
}
