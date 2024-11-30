//
//  TokenService.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 29.09.2024.
//

import Foundation

final class TokenService: TokenServiceProtocol {
    private let session: NetworkSessionProtocol
    private let authTokenRepository: AuthTokenRepositoryProtocol
    
    init(session: NetworkSessionProtocol, authTokenRepository: AuthTokenRepositoryProtocol) {
        self.session = session
        self.authTokenRepository = authTokenRepository
    }
    
    func accessToken() async -> EncodedToken? {
        return await authTokenRepository.getToken(for: .accessTokenKey)
    }
    
    func refreshToken() async -> EncodedToken? {
        return await authTokenRepository.getToken(for: .refreshTokenKey)
    }
    
    func refreshTokenPublisher() async throws {
        guard let refreshToken = await self.refreshToken() else {
            throw ARSAuthError.FailedToRetriveToken(message: "Refresh token is missing")
        }
        let dto = RefreshRequestDTO(refreshToken: refreshToken)
        let requestModel = BackendAPIRoute.refresh(with: dto)
        do {
            let dto: TokensResponseDTO = try await session.request(requestModel)
            await self.authTokenRepository.setToken(dto.accessToken, for: .accessTokenKey)
            await self.authTokenRepository.setToken(dto.refreshToken, for: .refreshTokenKey)
            return
        } catch let error as HTTPError {
            throw ARSAuthError.FailedToRetriveToken(message: error.customDescription)
        } catch {
            throw ARSAuthError.FailedToRetriveToken(message: error.localizedDescription)
        }
    }
    
    func isTokeValid() async -> Bool {
        guard
            let accessToken = await self.accessToken(),
            let decodedToken = try? await self.decodeToken(accessToken)
        else { return false }
        
        if Date().timeIntervalSince1970 < decodedToken.expirationTime {
            return true
        } else {
            return false
        }
    }
    
    func decodeToken(_ token: EncodedToken) async throws -> Token {
        guard let accessToken = await self.accessToken() else {
            fatalError()
        }
        let token = JWTDecoder.decodeJWT(accessToken)
        if token == nil {
            fatalError()
        }
        return token!
    }
}
