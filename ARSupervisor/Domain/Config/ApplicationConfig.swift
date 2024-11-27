//
//  ApplicationConfig.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 29.09.2024.
//

import Foundation

enum ApplicationConfigKey {
    static let backendAPIURL = "arsBackendAPIURL"
}

class ApplicationConfig {
    static func getConfigurationValue(for key: String) -> String {
        if let infoDictionary = Bundle.main.infoDictionary {
            if let value = infoDictionary[key] as? String {
                return value
            }
        }
        
        Logger.log(.error, "ApplicationConfig: value for key \(key) is missing")
        return ""
    }
}
