//
//  LoginUserUseCaseProtocol.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 01.10.2024.
//

import Combine

protocol LoginUserUseCaseProtocol {
    func execute(_ parameters: LoginRequestDTO) -> AnyPublisher<Void, any Error>
}
