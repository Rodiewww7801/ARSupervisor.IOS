//
//  User.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 25.09.2024.
//

class User {
    let credentials: UserCredentials
    var info: UserInfo?
    var accessLevel: UserAccessLevel = UserAccessLevel(securityLevel: 0)
    
    init(credentials: UserCredentials) {
        self.credentials = credentials
    }
}
