//
//  UserInfoDTO.swift
//  ARSupervisor
//
//  Created by rodiewww7801_temp on 27.11.2024.
//

struct UserInfoDTO: Decodable {
    let id: String
    let email: String?
    let imageURL: String?
    let firstName: String?
    let lastName: String?
    let role: String?
}

extension UserInfoDTO {
    func toModel() -> UserInfo {
        UserInfo(email: self.email, firstName: self.firstName, lastName: self.lastName, imageURL: self.imageURL)
    }
}
