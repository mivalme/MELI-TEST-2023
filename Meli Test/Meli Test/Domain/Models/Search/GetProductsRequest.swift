//
//  GetProductsRequest.swift
//  Meli Test
//
//  Created by Miguel Valcárcel on 17/05/23.
//

import Foundation

struct GetProductsRequest: Codable {
    let query: String
    
    enum CodingKeys: String, CodingKey {
        case query = "q"
    }
}
