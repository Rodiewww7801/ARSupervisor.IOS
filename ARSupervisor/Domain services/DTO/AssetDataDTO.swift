//
//  AssetDataDTO.swift
//  ARSupervisor
//
//  Created by rodiewww7801_temp on 05.11.2024.
//

import Foundation

struct AssetDataType: Decodable {
    let type: DataType
    
    enum DataType: String, Decodable {
        case chart
        case plain
        
        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            let rawValue = try container.decode(String.self)
            guard let _self =  DataType(rawValue: rawValue) else {
                throw DecodingError.keyNotFound(AssetDataType.CodingKeys.type, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Unknown DataType"))
            }
            self = _self
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case type = "data_type"
    }
}

struct AssetDataDTO<T: Decodable>: Decodable {
    let value: T
    
    enum CodingKeys: String, CodingKey {
        case value = "data_value"
    }
}

// MARK: - Data types

struct AssetChartData: Decodable {
    let x: Double
    let y: Double
}

struct AssetPlainData: Decodable {
    let value: Double?
}
