//
//  ARSupervisorAPIRequestFactory.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 29.09.2024.
//

import Foundation

class BackendAPIRequestFactory {
    static var serverAPI: String {
        ApplicationConfig.getConfigurationValue(for: ApplicationConfigKey.faceLockAPIUrl)
    }
    
    // MARK: - Authentication
    
    static func register(with dto: RegisterRequestDTO) -> RequestModel {
        let encodedData = try? JSONEncoder().encode(dto)
        let model = RequestModel(basePath: serverAPI, path: ARSupervisorAPIPath.register, httpMethod: .post)
        model.body = encodedData
        return model
    }
    
    static func login(with dto: LoginRequestDTO) -> RequestModel {
        let encodedData = try? JSONEncoder().encode(dto)
        let model = RequestModel(basePath: serverAPI, path: ARSupervisorAPIPath.login, httpMethod: .post)
        model.body = encodedData
        return model
    }
    
    static func refresh(with dto: RefreshRequestDTO) -> RequestModel {
        let encodedData = try? JSONEncoder().encode(dto)
        let model = RequestModel(basePath: serverAPI, path: ARSupervisorAPIPath.refresh, httpMethod: .post)
        model.body = encodedData
        return model
    }
    
    static func logout() -> RequestModel {
        let model = RequestModel(basePath: serverAPI, path: ARSupervisorAPIPath.logout, httpMethod: .post)
        return model
    }
}

