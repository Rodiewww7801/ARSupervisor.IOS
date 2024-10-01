//
//  RequestModel.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 28.09.2024.
//

import Foundation

class RequestModel {
    var basePath: String
    var path: String
    var httpMethod: HTTPMethod
    var headers: [String : String]?
    var queryParameters: [String : String]?
    var body: Data?
    
    init(basePath: String,
         path: String,
         httpMethod: HTTPMethod,
         headers: [String : String]? = nil,
         queryParameters: [String : String]? = nil,
         body: Data? = nil) {
        self.basePath = basePath
        self.path = path
        self.httpMethod = httpMethod
        self.headers = headers
        self.queryParameters = queryParameters
        self.body = body
    }
}
