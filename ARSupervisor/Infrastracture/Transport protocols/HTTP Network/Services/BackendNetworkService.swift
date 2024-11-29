//
//  BackendNetworkService.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 01.10.2024.
//

import Foundation

class BackendNetworkService: NetworkServiceProtocol {
    let authSession: NetworkSessionProtocol
    let session: NetworkSessionProtocol
    
    init(authSession: NetworkSessionProtocol,
         session: NetworkSessionProtocol
    ) {
        self.authSession = authSession
        self.session = session
    }
    
    func request<T>(_ requestModel: RequestModel) async throws -> T where T: Decodable {
        makeHttpHeaders(from: &requestModel.headers)
        do {
            let response: T = try await session.request(requestModel)
            return response
        } catch let error as HTTPError {
            throw error
        } catch {
            throw HTTPError.anyError(error)
        }
    }
    
    func authRequest<T>(_ requestModel: RequestModel) async throws -> T where T: Decodable {
        makeHttpHeaders(from: &requestModel.headers)
        do {
            let response: T = try await authSession.request(requestModel)
            return response
        } catch let error as HTTPError {
            throw error
        } catch {
            throw HTTPError.anyError(error)
        }
    }
    
    private func makeHttpHeaders(from headers: inout [String:String]?) {
        if headers == nil {
            headers =  [String:String]()
        }
        if headers?["Content-Type"] == nil {
            headers?.updateValue("application/json; charset=utf-8", forKey: "Content-Type")
        }
        headers?.updateValue("ARSupervisor.IOS", forKey: "Client")
    }
}
