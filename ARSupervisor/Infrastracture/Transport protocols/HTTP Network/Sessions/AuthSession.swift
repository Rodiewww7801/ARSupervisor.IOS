//
//  AuthSession.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 28.09.2024.
//

import Foundation

final class AuthSession: NetworkSessionProtocol {
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
            var requestModel = requestModel
            await self.addAuthHeaders(from: &requestModel.headers)
            let request: T = try await session.request(requestModel)
            return request
        } catch {
            try await self.tokenService.refreshTokenPublisher()
            let request: T = try await session.request(requestModel)
            return request
        }
    }
    
    func isSessionValid() async -> Bool {
        await self.tokenService.isTokeValid()
    }
    
    func addAuthHeaders(from headers: inout [String:String]?) async {
        if let accessToken = await tokenService.accessToken() {
            headers?.updateValue("\(accessToken)", forKey: "Authorization")
        }
    }
}
