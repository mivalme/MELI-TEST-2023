//
//  SearchUseCase.swift
//  Meli Test
//
//  Created by Miguel Valcárcel on 17/05/23.
//

import Foundation

final class SearchUseCase: BaseUseCase, SearchUseCaseProtocol {
    func getProducts(request: GetProductsRequest, completionHandler: @escaping (ServiceResponse<GetProductsResponse>) -> Void) {
        repository.request(url: DataConstants.Endpoint.search.url,
                           method: .get,
                           requestBody: request,
                           completionHandler: completionHandler)
    }
}
