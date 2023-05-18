//
//  DataConstants.swift
//  Meli Test
//
//  Created by Miguel Valcárcel on 17/05/23.
//

import Foundation

struct DataConstants {
    struct Request {
        static let contentType = "Content-Type"
        static let applicationJson = "application/json"
    }
    
    struct Environments {
        static let dev = "https://api.mercadolibre.com/"
    }
    
    enum ContentOrigin: String {
        case sites = "sites/MLA/"
    }
    
    enum Endpoint {
        case search
        
        var url: String {
            switch self {
            case .search:
                return ContentOrigin.sites.rawValue + "search"
            }
        }
    }
}
