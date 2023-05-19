//
//  DataConstants.swift
//  Meli Test
//
//  Created by Miguel Valcárcel on 17/05/23.
//

import Foundation

struct DataConstants {
    struct Request {
        static let applicationJson = "application/json"
        static let contentType = "Content-Type"
    }
    
    struct Environments {
        static let dev = "https://api.mercadolibre.com/"
    }
    
    enum ContentOrigin: String {
        case items = "items"
        case sites = "sites/MCO/"
    }
    
    enum Endpoint {
        case categories
        case items
        case search
        
        var url: String {
            switch self {
            case .categories:
                return ContentOrigin.sites.rawValue + "categories"
            case .items:
                return ContentOrigin.items.rawValue
            case .search:
                return ContentOrigin.sites.rawValue + "search"
            }
        }
    }
}
