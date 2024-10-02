//
//  RegisterUserUseCaseProtocol.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 01.10.2024.
//

import Combine

protocol RegisterUserUseCaseProtocol {
    func execute(_ dto: RegisterRequestDTO) -> AnyPublisher<Void, ARSAuthError>
}
