//
//  Product.swift
//  Meli Test
//
//  Created by Miguel Valcárcel on 18/05/23.
//

import Foundation

struct Product: Codable {
    let id: String
    let title: String
    let thumbnailId: String
    let price: Int
    let installments: Installments
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case thumbnailId = "thumbnail_id"
        case price
        case installments
    }
}

struct Installments: Codable {
    let quantity: Int
    let amount: Double
    let rate: Int
}
