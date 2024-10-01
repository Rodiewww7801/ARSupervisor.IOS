//
//  User.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 25.09.2024.
//

class User {
    let info: UserInfo
    let accessLevel: UserAccessLevel
    let credentials: UserCredentials
    
    init(credentials: UserCredentials, info: UserInfo, accessLevel: UserAccessLevel) {
        self.credentials = credentials
        self.info = info
        self.accessLevel = accessLevel
    }
}
