//
//  UserDataRepository.swift
//  ARSupervisor
//
//  Created by rodiewww7801_temp on 28.11.2024.
//

import SwiftData

@ModelActor
actor UserDataRepository: @preconcurrency UserDataRepositoryProtocol {
    func getCurrentUser() throws -> UserInfoDTO {
        return try self.getCurrentSDUser().toModel()
    }
    
    func saveUser(_ user: UserInfoDTO) throws {
        let userSD = SDUser(user)
        self.modelContext.insert(userSD)
        try modelContext.save()
    }
    
    private func getCurrentSDUser() throws -> SDUser {
        let descriptor = FetchDescriptor<SDUser>()
        let user = try modelContext.fetch(descriptor).first
        if let user  {
            return user
        } else {
            throw ARSPersistanceError.UserDosentExist
        }
    }
}
