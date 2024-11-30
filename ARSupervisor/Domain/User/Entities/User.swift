//
//  User.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 25.09.2024.
//

@UserManagerActor
class User: Sendable {
    let id: String
    var info: UserInfo?
    var accessLevel: UserAccessLevel = UserAccessLevel(securityLevel: 0)
    
    init(id: String) {
        self.id = id
    }
}
