//
//  UserDataRepository.swift
//  ARSupervisor
//
//  Created by rodiewww7801_temp on 28.11.2024.
//

import SwiftData
import Foundation


actor UserDataRepository: UserDataRepositoryProtocol {
    private let database: any DatabaseProtocol<SDUser>
    
    init(database: any DatabaseProtocol<SDUser>) {
        self.database = database
    }
    
    func getCurrentUser() async throws -> UserInfoDTO? {
        return try await self.database.read(predicate: nil, sortDescriptors: []).first?.toModel()
    }
    
    func saveUser(_ user: UserInfoDTO) async throws {
        let userSD = SDUser(user)
        try await database.update(userSD)
    }
}
