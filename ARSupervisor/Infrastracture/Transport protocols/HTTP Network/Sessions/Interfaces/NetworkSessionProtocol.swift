//
//  NetworkSessionProtocol.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 28.09.2024.
//

import Foundation
import Combine

protocol NetworkSessionProtocol {
    func publisher<T>(_ requestModel: RequestModel) -> AnyPublisher<T, any Error> where T: Decodable
}
