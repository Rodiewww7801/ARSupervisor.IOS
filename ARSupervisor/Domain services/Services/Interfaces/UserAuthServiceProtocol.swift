//
//  UserAuthServiceProtocol.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 01.10.2024.
//

import Combine

protocol UserAuthServiceProtocol {
    func login(_ credentials: UserCredentials) -> AnyPublisher<Void, ARSAuthError>
    func register(_ user: User) -> AnyPublisher<Void, ARSAuthError>
    func logout() -> AnyPublisher<Void, any Error>
}
