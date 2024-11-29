//
//  UserSD.swift
//  ARSupervisor
//
//  Created by rodiewww7801_temp on 28.11.2024.
//

import SwiftData

@Model
final class SDUser {
    @Attribute(.unique)
    var id: String
    var email: String?
    var firstName: String?
    var lastName: String?
    var imageURL: String?
    
    init(id: String, email: String? = nil, firstName: String? = nil, lastName: String? = nil, imageURL: String? = nil) {
        self.id = id
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.imageURL = imageURL
    }
    
    convenience init(_ user: UserInfoDTO) {
        self.init(id: user.id,
                  email: user.email,
                  firstName: user.firstName,
                  lastName: user.lastName,
                  imageURL: user.imageURL)
    }
}

extension SDUser {
    func toModel() -> UserInfoDTO {
        let user = UserInfoDTO(
            id: self.id,
            email: self.email,
            imageURL: self.firstName,
            firstName: self.lastName,
            lastName: self.imageURL,
            role: nil)
        return user
    }
    
    func update(_ user: UserInfoDTO) {
        self.id = user.id
        self.email = user.email
        self.firstName = user.firstName
        self.lastName = user.lastName
        self.imageURL = user.imageURL
    }
}
