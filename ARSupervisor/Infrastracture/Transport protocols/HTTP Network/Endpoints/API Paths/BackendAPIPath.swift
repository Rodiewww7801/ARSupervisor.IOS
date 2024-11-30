//
//  BackendAPIPath.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 29.09.2024.
//

enum BackendAPIPath {
    
    // MARK: - Authentication
    static let register = "/api/auth/register"
    static let login = "/api/auth/login"
    static let refresh = "/api/auth/refresh"
    
    //MARK: - User
    static let userInfo = "/api/user/{userId}"
}
