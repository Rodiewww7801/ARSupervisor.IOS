//
//  UserManagerProtocol.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 01.10.2024.
//

import Combine

protocol UserManagerProtocol {
    func authUser(_ user: User) -> AnyPublisher<Void, any Error>
}
