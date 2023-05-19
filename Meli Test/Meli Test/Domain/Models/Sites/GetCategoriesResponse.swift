//
//  GetCategoriesResponse.swift
//  Meli Test
//
//  Created by Miguel Valcárcel on 19/05/23.
//

import Foundation

typealias GetCategoriesResponse = [ProductCategory]

struct ProductCategory: Codable {
    let id: String
    let name: String
}
