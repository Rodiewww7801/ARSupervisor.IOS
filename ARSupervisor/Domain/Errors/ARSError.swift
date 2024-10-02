//
//  ARSError.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 02.10.2024.
//

protocol ARSError: Error { }

enum ARSAuthError: ARSError {
    case UserRegistrationError(message: String)
    case UserAuthenticationError(message: String)
    case FailedToRetriveToken(message: String)
    
    var customDescription: String {
        switch self {
        case .UserRegistrationError(let message):
            return message
        case .UserAuthenticationError(let message):
            return message
        case .FailedToRetriveToken(let message):
            return message
        }
    }
}
