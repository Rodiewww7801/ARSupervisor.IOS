//
//  DefaultSession.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 02.10.2024.
//

import Foundation
import Combine

class DefaultSession: NetworkSessionProtocol {
    private let session: URLSession
    
    init() {
        session = URLSession.shared
    }
    
    func publisher<T: Decodable>(_ requestModel: RequestModel) -> AnyPublisher<T, any Error> {
        makeRequest(requestModel)
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error -> any Error in
                Logger.log(.error, "\(error)")
                if let error = error as? DecodingError {
                    return HTTPError.decodeError(error.localizedDescription)
                } else if let error = error as? HTTPError {
                    return error
                } else {
                    return error
                }
            }.eraseToAnyPublisher()
    }
    
    private func makeRequest(_ requestModel: RequestModel) -> AnyPublisher<Data, any Error> {
        session.publisher(requestModel)
            .tryMap { (data, response) in
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
            }.eraseToAnyPublisher()
    }
}
