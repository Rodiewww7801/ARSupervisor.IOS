//
//  SecureStorageError.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 29.09.2024.
//

import Foundation

enum SecureStorageError: Error {
    case readError(Error)
    case saveError(Error)
    case deleteError(Error)
    case emptyResponseError
    case conversionError
    case unhandledError(message: String)
}
