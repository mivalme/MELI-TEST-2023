//
//  BaseResponse.swift
//  Meli Test
//
//  Created by Miguel Valcárcel on 17/05/23.
//

import Foundation

struct BaseResponse<T: Codable>: Codable {
    let data: T?
    let message: String?
    let errors: [Error]?
    let metadata: Metadata?
    
    struct Error: Codable {
        let path: String?
        let message: String?
    }

    struct Metadata: Codable {
        let pagination: Pagination?
        
        struct Pagination: Codable {
            let page: Int
            let pageSize: Int
            let totalPages: Int
        }
    }
}
