//
//  TokenService.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 29.09.2024.
//

import Foundation
import Combine

class TokenService: TokenServiceProtocol {
    private let session: NetworkSessionProtocol
    private let authTokenRepository: AuthTokenRepositoryProtocol
    private var subcriptions: Set<AnyCancellable> = .init()
    
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
    
    func refreshTokenPublisher() -> AnyPublisher<Void, any Error> {
        guard let refreshToken = authTokenRepository.getToken(for: .refreshTokenKey) else {
            return Future<Void, any Error> { promise in
                promise(.failure(HTTPError.tokenIsMissing))
            }.eraseToAnyPublisher()
        }
        
        let dto = RefreshRequestDTO(refreshToken: refreshToken)
        let requestModel = BackendAPIRequestFactory.refresh(with: dto)
        let refreshTokenRequestPublisher: AnyPublisher<TokensResponseDTO, any Error> = session.publisher(requestModel)
        
        return refreshTokenRequestPublisher
            .flatMap({ dto -> AnyPublisher<Void, any Error> in
                Future { promise in
                    self.authTokenRepository.setToken(dto.accessToken, for: .accessTokenKey)
                    self.authTokenRepository.setToken(dto.refreshToken, for: .refreshTokenKey)
                    promise(.success( () ))
                }.eraseToAnyPublisher()
            }).eraseToAnyPublisher()
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
