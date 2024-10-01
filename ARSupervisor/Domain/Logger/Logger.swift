//
//  Logger.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 28.09.2024.
//

class Logger {
    enum Level {
        case verbose
        case error
        case info
        case memmoryInfo
        
        func description() -> String {
            switch self {
            case .verbose:
                return "Verbose"
            case .error:
                return "Error"
            case .info:
                return "Info"
            case .memmoryInfo:
                return "Memmory"
            }
        }
    }
    
    
    static func log(_ level: Logger.Level = .verbose,  _ message: String) {
        print("[\(level.description())] \(message)")
    }
    
    static func log<T>(_ level: Logger.Level = .verbose, for instance: T,  _ message: String) {
        print("[\(level.description()): \(type(of: instance))] \(message)")
    }
    
    static func logAllocation<T>(for instance: T) {
        print("[\(Logger.Level.memmoryInfo.description()): \(type(of: instance))] Memory allocated for instance")
    }
    
    static func logDeallocation<T>(for instance: T) {
        print("[\(Logger.Level.memmoryInfo.description()): \(type(of: instance))] Memory deallocated for instance")
    }
}
