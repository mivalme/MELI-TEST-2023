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
    let installments: Installments?
    var pictures: [Picture]?
    var condition: ProductCondition?
    var acceptsMercadopago: Bool?
    var shipping: ProductShipping?
    var soldQuantity: Int?
    var availableQuantity: Int?
    var attributes: [ProductAttribute]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case thumbnailId = "thumbnail_id"
        case price
        case installments
        case pictures
        case condition
        case acceptsMercadopago = "accepts_mercadopago"
        case shipping
        case soldQuantity = "sold_quantity"
        case availableQuantity = "available_quantity"
        case attributes
    }
}

struct Installments: Codable {
    let quantity: Int
    let amount: Double
    let rate: Int
}

struct Picture: Codable {
    let id: String
    let url: String
}

enum ProductCondition: String, Codable, UnknownCase {
    case new
    case used
    case unknown
    
    var title: String {
        switch self {
        case .new:
            return "Nuevo"
        case .used:
            return "Usado"
        case .unknown:
            return ""
        }
    }
}

struct ProductShipping: Codable {
    let freeShipping: Bool
    
    enum CodingKeys: String, CodingKey {
        case freeShipping = "free_shipping"
    }
}

struct ProductAttribute: Codable {
    let id: String
    let name: String
    let valueName: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case valueName = "value_name"
    }
}
