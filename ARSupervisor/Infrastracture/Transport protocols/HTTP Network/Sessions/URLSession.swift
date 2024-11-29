//
//  URLSession.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 28.09.2024.
//

import Foundation

extension URLSession {
    
    typealias URLRessponse = (Data, URLResponse)
    
    private var requestBuilder: RequestBuilderProtocol {
        return dependency.networkDependency.makeRequestBuilder()
    }
    
    func request(_ requestModel: RequestModel) async throws -> URLRessponse {
        let request = requestBuilder.buildRequest(requestModel)
        Logger.log(.httpRequest, "url: \(request.debugDescription), headers: \(request.allHTTPHeaderFields ?? [:]), method: \(request.httpMethod ?? "")")
        let (data, response) = try await self.data(for: request)
        Logger.log(.httpResponse, "response: \(response.debugDescription)\n data: \(String(data:data, encoding: .utf8) ?? "")")
        return (data, response)
    }
}
