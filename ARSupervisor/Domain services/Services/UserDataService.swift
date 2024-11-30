//
//  UserDataService.swift
//  ARSupervisor
//
//  Created by rodiewww7801_temp on 28.11.2024.
//

actor UserDataService: UserDataServiceProtocol {
    private let getUserInfoUseCase: GetUserInfoUseCaseProtocol
    private let getCurrentUserDBUseCase: GetCurrentUserDBUseCaseProtocol
    private let saveUserDBUseCase: SaveUserDBUseCaseProtocol
    
    init(getUserInfoUseCase: GetUserInfoUseCaseProtocol,
         getCurrentUserDBUseCase: GetCurrentUserDBUseCaseProtocol,
         saveUserDBUseCase: SaveUserDBUseCaseProtocol) {
        self.getUserInfoUseCase = getUserInfoUseCase
        self.getCurrentUserDBUseCase = getCurrentUserDBUseCase
        self.saveUserDBUseCase = saveUserDBUseCase
    }
    
    func getUserInfo(for userId: String) async throws -> UserInfo {
        let dto = try await getUserInfoUseCase.execute(userId)
        let userInfo = dto.toModel()
        return userInfo
    }
   
    func getCurrentUserDB() async throws -> User? {
        let dto = try await self.getCurrentUserDBUseCase.execute()
        guard let dto else { return nil }
        let user = await Task { @UserManagerActor in
            let user = User(id: dto.id)
            user.info = dto.toModel()
            return user
        }.value
        return user
    }
    
    func saveUserDB(_ user: User) async throws {
        let dto = await UserInfoDTO(id: user.id,
                              email: user.info?.email,
                              imageURL: user.info?.imageURL,
                              firstName: user.info?.firstName,
                              lastName: user.info?.lastName,
                              role: nil)
        try await saveUserDBUseCase.execute(dto)
    }
}
