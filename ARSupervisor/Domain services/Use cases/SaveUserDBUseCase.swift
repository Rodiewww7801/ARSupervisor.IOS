//
//  SaveUserDBUseCase.swift
//  ARSupervisor
//
//  Created by rodiewww7801_temp on 28.11.2024.
//

class SaveUserDBUseCase: SaveUserDBUseCaseProtocol {
    private let userDataRepository: UserDataRepositoryProtocol
    
    init(userDataRepository: UserDataRepositoryProtocol) {
        self.userDataRepository = userDataRepository
    }
    
    func execute(_ user: UserInfoDTO) async throws {
        try await userDataRepository.saveUser(user)
    }
}
