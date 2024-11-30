//
//  LoginUserUseCase.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 01.10.2024.
//

final class LoginUserUseCase: LoginUserUseCaseProtocol {
    private let backendService: NetworkServiceProtocol
    private let authTokenRepository: AuthTokenRepositoryProtocol
    
    init(backendService: NetworkServiceProtocol,
         authTokenRepository: AuthTokenRepositoryProtocol) {
        self.backendService = backendService
        self.authTokenRepository = authTokenRepository
    }
   
    func execute(_ dto: LoginRequestDTO) async throws -> LoginResponseDTO {
        let requestModel = BackendAPIRoute.login(with: dto)
        do {
            let dto: LoginResponseDTO = try await backendService.request(requestModel)
            await self.authTokenRepository.setToken(dto.accessToken, for: .accessTokenKey)
            await self.authTokenRepository.setToken(dto.refreshToken, for: .accessTokenKey)
            return dto
        } catch let error as HTTPError {
            throw ARSAuthError.UserAuthenticationError(message: error.customDescription)
        }
    }
}
