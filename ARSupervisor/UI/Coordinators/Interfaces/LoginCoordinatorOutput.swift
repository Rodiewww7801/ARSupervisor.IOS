//
//  LoginCoordinatorOutput.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 02.10.2024.
//

import Combine

@MainActor
protocol LoginCoordinatorOutput {
    var onSuccessLogin: AnyPublisher<Void, Never> { get }
}
