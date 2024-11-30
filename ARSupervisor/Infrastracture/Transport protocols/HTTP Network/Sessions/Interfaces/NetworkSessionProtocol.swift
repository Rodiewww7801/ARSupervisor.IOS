//
//  NetworkSessionProtocol.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 28.09.2024.
//

import Foundation

protocol NetworkSessionProtocol: Sendable {
    func request<T>(_ requestModel: RequestModel) async throws -> T where T: Decodable
}
