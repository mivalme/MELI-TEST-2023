//
//  SitesUseCase.swift
//  Meli Test
//
//  Created by Miguel Valcárcel on 17/05/23.
//

import Foundation

final class SitesUseCase: BaseUseCase, SitesUseCaseProtocol {
    func getCategories(completionHandler: @escaping (ServiceResponse<GetCategoriesResponse>) -> Void) {
        repository.request(url: DataConstants.Endpoint.categories.url,
                           method: .get,
                           requestBody: nil,
                           completionHandler: completionHandler)
    }
    
    func getProducts(request: GetProductsRequest, completionHandler: @escaping (ServiceResponse<GetProductsResponse>) -> Void) {
        repository.request(url: DataConstants.Endpoint.search.url,
                           method: .get,
                           requestBody: request,
                           completionHandler: completionHandler)
    }
}
