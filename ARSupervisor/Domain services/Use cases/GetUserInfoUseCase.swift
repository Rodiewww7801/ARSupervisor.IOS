//
//  GetUserInfoUseCase.swift
//  ARSupervisor
//
//  Created by rodiewww7801_temp on 27.11.2024.
//

final class GetUserInfoUseCase: GetUserInfoUseCaseProtocol {
    private let backendService: NetworkServiceProtocol
    
    init(backendService: NetworkServiceProtocol) {
        self.backendService = backendService
    }
    
    func execute(_ userId: String) async throws -> UserInfoDTO {
        let requestModel = BackendAPIRoute.getUserInfo(for: userId)
        let dto: UserInfoDTO = try await backendService.authRequest(requestModel)
        return dto
    }
}
