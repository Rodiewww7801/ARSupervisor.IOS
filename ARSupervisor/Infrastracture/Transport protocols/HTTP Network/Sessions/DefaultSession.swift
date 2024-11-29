//
//  DefaultSession.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 02.10.2024.
//

import Foundation

class DefaultSession: NetworkSessionProtocol {
    private let session: URLSession
    
    init() {
        session = URLSession.shared
    }
    
    func request<T: Decodable>(_ requestModel: RequestModel) async throws -> T {
        do {
            let data = try await makeRequest(requestModel)
            let decoded = try JSONDecoder().decode(T.self, from: data)
            return decoded
        } catch {
            Logger.log(.error, "\(error)")
            if let error = error as? DecodingError {
                throw HTTPError.decodeError(error.localizedDescription)
            } else if let error = error as? HTTPError {
                throw error
            } else {
                throw error
            }
        }
    }
    
    private func makeRequest(_ requestModel: RequestModel) async throws -> Data {
        let (data, response) = try await session.request(requestModel)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw HTTPError.requestFailed()
        }
        
        if (200...299) ~= httpResponse.statusCode {
            return data
        } else if httpResponse.statusCode == 401 {
            throw HTTPError.authenticationError
        } else if httpResponse.statusCode == 403 {
            throw HTTPError.authorizationError
        } else {
            if var error = try? JSONDecoder().decode(HTTPErrorDTO.self, from: data) {
                error.statusCode = httpResponse.statusCode
                throw HTTPError.requestFailed(error)
            } else if let message = String(data: data, encoding: .utf8) {
                throw HTTPError.requestFailed(
                    HTTPErrorDTO(message: message,
                                 statusCode: httpResponse.statusCode)
                )
            } else {
                throw HTTPError.failed(statusCode: httpResponse.statusCode)
            }
        }
    }
}
