//
//  LoginResponseDTO.swift
//  ARSupervisor
//
//  Created by rodiewww7801_temp on 29.11.2024.
//

struct LoginResponseDTO: Decodable {
    let userId: String
    let accessToken: String
    let refreshToken: String
}
