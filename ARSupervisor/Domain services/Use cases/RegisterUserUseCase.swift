//
//  RegisterUserUseCase.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 01.10.2024.
//

import Combine

class RegisterUserUseCase: RegisterUserUseCaseProtocol {
    private let backendService: NetworkServiceProtocol
    
    init(backendService: NetworkServiceProtocol) {
        self.backendService = backendService
    }
    
    func execute(_ dto: RegisterRequestDTO) -> AnyPublisher<Void, ARSAuthError> {
        let requestModel = BackendAPIRequestFactory.register(with: dto)
        let publisher: AnyPublisher<EmptyResponse, HTTPError> = backendService.request(requestModel)
        return publisher
            .mapError { error -> ARSAuthError in
                return ARSAuthError.UserRegistrationError(message: "\(error)")
            }
            .flatMap { dto -> Future<Void, ARSAuthError> in
                Future<Void, ARSAuthError> { promise in
                    promise(.success( Void() ))
                }
            }.eraseToAnyPublisher()
        
    }
}
