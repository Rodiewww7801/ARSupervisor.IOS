//
//  UserManagerProtocol.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 01.10.2024.
//

import Combine

protocol UserManagerProtocol {
    func authUser(_ credentials: UserCredentials) -> AnyPublisher<Void, ARSAuthError>
    func registerUser(_ user: User) -> AnyPublisher<Void, ARSAuthError>
}
