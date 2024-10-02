//
//  HTTPError.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 28.09.2024.
//

import Foundation

struct HTTPErrorDTO: Decodable {
    var message: String
    var statusCode: Int?
}

enum HTTPError: Error {
    case requestFailed(_ error: HTTPErrorDTO? = nil)
    case anyError(Error)
    case authenticationError
    case authorizationError
    case tokenIsMissing
    case decodeError(_ message: String)
    case failed(statusCode: Int)

    var customDescription: String {
        switch self {
        case .requestFailed(let error):
            if let error, let statusCode = error.statusCode {
                return "Request failed with status code: \(statusCode) and message: \(error.message)"
            } else {
                return "Request failed"
            }
        case .anyError(let error):
            return error.localizedDescription
        case .authenticationError:
            return "Unauthorized"
        case .authorizationError:
            return "Forbidden"
        case .tokenIsMissing:
            return "Token is missing"
        case .decodeError(let message):
            return message
        case .failed(let statusCode):
            return  "Request failed with status code: \(statusCode)"
        }
    }
}
