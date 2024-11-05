//
//  DependencyContainer + DomainDependency.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 01.10.2024.
//

protocol DomainDependency {
    var userManager: UserManagerProtocol { get }
    var cameraManager: CameraManagerProtocol { get }
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
    
    var cameraManager: CameraManagerProtocol {
        if let _cameraManager {
            return _cameraManager
        }
        
        _cameraManager = makeCameraManager()
        return _cameraManager
    }
    
    private func makeCameraManager() -> CameraManagerProtocol {
        CameraManager()
    }
}
