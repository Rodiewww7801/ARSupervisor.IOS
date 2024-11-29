//
//  NetworkService.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 01.10.2024.
//

protocol NetworkServiceProtocol {
    func request<T>(_ requestModel: RequestModel) async throws -> T where T: Decodable
    func authRequest<T>(_ requestModel: RequestModel) async throws -> T where T : Decodable

}
