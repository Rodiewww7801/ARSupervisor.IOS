//
//  URLSession.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 28.09.2024.
//

import Foundation
import Combine

extension URLSession {
    
    typealias URLRessponse = (Data, URLResponse)
    
    private var requestBuilder: RequestBuilderProtocol {
        return dependency.networkDependency.makeRequestBuilder()
    }
    
    func publisher(_ requestModel: RequestModel) -> AnyPublisher<URLRessponse, URLError> {
        let request = requestBuilder.buildRequest(requestModel)
        Logger.log(.httpRequest, "url: \(request.debugDescription), headers: \(request.allHTTPHeaderFields ?? [:]), method: \(request.httpMethod ?? "")")
        let publisher = self.dataTaskPublisher(for: request)
            .map { (data: Data, response: URLResponse) -> URLRessponse in
                Logger.log(.httpResponse, "response: \(response.debugDescription)\n data: \(String(data:data, encoding: .utf8) ?? "")")
                return (data, response)
            }
            .eraseToAnyPublisher()
        return publisher
    }
}
