//
//  SearchUseCaseProtocol.swift
//  Meli Test
//
//  Created by Miguel Valcárcel on 17/05/23.
//

import Foundation

protocol SearchUseCaseProtocol {
    func getProducts(request: GetProductsRequest, completionHandler: @escaping (ServiceResponse<GetProductsResponse>) -> Void)
}
