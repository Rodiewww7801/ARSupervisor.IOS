//
//  TokensResponseDTO.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 29.09.2024.
//

struct TokensResponseDTO: Decodable {
    let accessToken: String
    let refreshToken: String
}
