//
//  ItemsUseCase.swift
//  Meli Test
//
//  Created by Miguel Valcárcel on 18/05/23.
//

import Foundation

final class ItemsUseCase: BaseUseCase, ItemsUseCaseProtocol {
    func getItems(request: GetItemsRequest, completionHandler: @escaping (ServiceResponse<[GetItemsResponse]>) -> Void) {
        repository.request(url: DataConstants.Endpoint.items.url,
                           method: .get,
                           requestBody: request,
                           completionHandler: completionHandler)
    }
}
