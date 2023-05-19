//
//  SitesUseCaseProtocol.swift
//  Meli Test
//
//  Created by Miguel Valcárcel on 17/05/23.
//

import Foundation

protocol SitesUseCaseProtocol {
    func getCategories(completionHandler: @escaping (ServiceResponse<GetCategoriesResponse>) -> Void)
    func getProducts(request: GetProductsRequest, completionHandler: @escaping (ServiceResponse<GetProductsResponse>) -> Void)
}
