//
//  GetCurrentUserDBUseCase.swift.swift
//  ARSupervisor
//
//  Created by rodiewww7801_temp on 29.11.2024.
//

final class GetCurrentUserDBUseCase: GetCurrentUserDBUseCaseProtocol {
    private let userDataRepository: UserDataRepositoryProtocol
    
    init(userDataRepository: UserDataRepositoryProtocol) {
        self.userDataRepository = userDataRepository
    }
    
    func execute() async throws -> UserInfoDTO? {
        try await userDataRepository.getCurrentUser()
    }
}
