//
//  RequestBuilderProtocol.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 28.09.2024.
//

import Foundation

protocol RequestBuilderProtocol {
    func buildRequest(_ requestModel: RequestModel) -> URLRequest
}
