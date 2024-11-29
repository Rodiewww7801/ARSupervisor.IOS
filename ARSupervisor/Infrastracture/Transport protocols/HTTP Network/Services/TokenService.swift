//
//  TokenService.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 29.09.2024.
//

import Foundation

class TokenService: TokenServiceProtocol {
    private let session: NetworkSessionProtocol
    private let authTokenRepository: AuthTokenRepositoryProtocol
    
    var accessToken: EncodedToken? {
        return authTokenRepository.getToken(for: .accessTokenKey)
    }
    var refreshToken: EncodedToken? {
        return authTokenRepository.getToken(for: .refreshTokenKey)
    }
    
    init(session: NetworkSessionProtocol, authTokenRepository: AuthTokenRepositoryProtocol) {
        self.session = session
        self.authTokenRepository = authTokenRepository
    }
    
    func refreshTokenPublisher() async throws {
        guard let refreshToken = authTokenRepository.getToken(for: .refreshTokenKey) else {
            throw ARSAuthError.FailedToRetriveToken(message: "Refresh token is missing")
        }
        let dto = RefreshRequestDTO(refreshToken: refreshToken)
        let requestModel = BackendAPIRequestFactory.refresh(with: dto)
        do {
            let dto: TokensResponseDTO = try await session.request(requestModel)
            self.authTokenRepository.setToken(dto.accessToken, for: .accessTokenKey)
            self.authTokenRepository.setToken(dto.refreshToken, for: .refreshTokenKey)
            return
        } catch let error as HTTPError {
            throw ARSAuthError.FailedToRetriveToken(message: error.customDescription)
        } catch {
            throw ARSAuthError.FailedToRetriveToken(message: error.localizedDescription)
        }
    }
    
    var isTokeValid: Bool {
        guard
            let accessToken = self.accessToken,
            let decodedToken = try? self.decodeToken(accessToken)
        else { return false }
        
        if Date().timeIntervalSince1970 < decodedToken.expirationTime {
            return true
        } else {
            return false
        }
    }
    
    func decodeToken(_ token: EncodedToken) throws -> Token {
        guard let accessToken = authTokenRepository.getToken(for: .accessTokenKey) else {
            fatalError()
        }
        let token = JWTDecoder.decodeJWT(accessToken)
        if token == nil {
            fatalError()
        }
        return token!
    }
}
