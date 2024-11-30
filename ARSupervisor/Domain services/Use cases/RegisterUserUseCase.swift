//
//  RegisterUserUseCase.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 01.10.2024.
//

final class RegisterUserUseCase: RegisterUserUseCaseProtocol {
    private let backendService: NetworkServiceProtocol
    
    init(backendService: NetworkServiceProtocol) {
        self.backendService = backendService
    }
    
    func execute(_ dto: RegisterRequestDTO) async throws {
        let requestModel = BackendAPIRequestFactory.register(with: dto)
        do {
            let _: EmptyResponse = try await backendService.request(requestModel)
            return
        } catch let error as ARSAuthError {
            throw ARSAuthError.UserRegistrationError(message: error.localizedDescription)
        }
    }
}
