//
//  AuthSession.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 28.09.2024.
//

import Foundation

class AuthSession: NetworkSessionProtocol {
    let session: NetworkSessionProtocol
    let tokenService: TokenServiceProtocol
    let sessionQueue: DispatchQueue = DispatchQueue(label: "auth.session.queue.\(UUID().uuidString)")
    
    init(
        session: NetworkSessionProtocol,
        tokenService: TokenServiceProtocol
    ) {
        self.session = session
        self.tokenService = tokenService
    }
    
    func request<T>(_ requestModel: RequestModel) async throws -> T where T: Decodable {
        do {
            self.addAuthHeaders(from: &requestModel.headers)
            let request: T = try await session.request(requestModel)
            return request
        } catch {
            try await self.tokenService.refreshTokenPublisher()
            let request: T = try await session.request(requestModel)
            return request
        }
    }
    
    func isSessionValid() -> Bool {
        self.tokenService.isTokeValid
    }
    
    func addAuthHeaders(from headers: inout [String:String]?) {
        if let accessToken = tokenService.accessToken {
            headers?.updateValue("\(accessToken)", forKey: "Authorization")
        }
    }
}
