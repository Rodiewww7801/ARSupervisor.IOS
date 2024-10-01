//
//  NetworkService.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 01.10.2024.
//

import Combine

protocol NetworkServiceProtocol {
    func request<T>(_ requestModel: RequestModel) -> AnyPublisher<T, Error> where T: Decodable
    func authRequest<T>(_ requestModel: RequestModel) -> AnyPublisher<T, Error> where T: Decodable
}
