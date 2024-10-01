//
//  Token.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 29.09.2024.
//

import Foundation

struct Token: Decodable {
    var clientId: String
    var userId: String
    var role: String
    var expirationTime: TimeInterval
    
    enum CodingKeys: String, CodingKey {
        case clientId = "clientId"
        case userId = "userId"
        case role = "role"
        case expirationTime = "exp"
    }
}
