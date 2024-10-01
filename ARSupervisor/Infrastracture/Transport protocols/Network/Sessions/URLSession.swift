//
//  URLSession.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 28.09.2024.
//

import Foundation
import Combine

extension URLSession: NetworkSessionProtocol {
    
    private var requestBuilder: RequestBuilderProtocol {
        return dependency.networkFactory.makeRequestBuilder()
    }
    
    func publisher<T>(_ requestModel: RequestModel) -> AnyPublisher<T, Error> where T: Decodable {
        let request = requestBuilder.buildRequest(requestModel)
        let publisher = self.dataTaskPublisher(for: request)
            .tryMap { result in
                guard let httpResponse = result.response as? HTTPURLResponse else {
                    throw HTTPError.requestFailed()
                }
                
                if (200...299) ~= httpResponse.statusCode {
                    return result.data
                } else if httpResponse.statusCode == 401 {
                    throw HTTPError.authenticationError
                } else if httpResponse.statusCode == 403 {
                    throw HTTPError.authorizationError
                } else {
                    if var error = try? JSONDecoder().decode(HTTPErrorDTO.self, from: result.data) {
                        error.statusCode = httpResponse.statusCode
                        throw HTTPError.requestFailed(error)
                    } else {
                        throw HTTPError.failed(statusCode: httpResponse.statusCode)
                    }
                }
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
        
        return publisher
    }
}
