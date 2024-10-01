//
//  UserAuthServiceProtocol.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 01.10.2024.
//

import Combine

protocol UserAuthServiceProtocol {
    func login(user: User) -> AnyPublisher<Void, any Error>
    func register(user: User) -> AnyPublisher<Void, any Error>
    func logout() -> AnyPublisher<Void, any Error>
}
