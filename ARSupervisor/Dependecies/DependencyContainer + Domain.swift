//
//  DependencyContainer + DomainDependency.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 01.10.2024.
//

protocol DomainDependency {
    var userManager: UserManagerProtocol { get }
}

extension DependencyContainerProtected: DomainDependency  {
    var userManager: UserManagerProtocol {
        if let _userManager {
            return _userManager
        }
        
        _userManager = makeUserManager()
        return _userManager
    }
    
    private func makeUserManager() -> UserManagerProtocol {
        UserManager(userAuthService: domainServiceDependency.makeUserAuthService())
    }
}
