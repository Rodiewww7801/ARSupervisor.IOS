//
//  NetworkSessionProtocol.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 28.09.2024.
//

import Foundation
import Combine

protocol NetworkSessionProtocol {
    func publisher<T>(_ requestModel: RequestModel) -> AnyPublisher<T, Error> where T: Decodable 
}
