//
//  ItemsUseCaseProtocol.swift
//  Meli Test
//
//  Created by Miguel Valcárcel on 18/05/23.
//

import Foundation

protocol ItemsUseCaseProtocol {
    func getItems(request: GetItemsRequest, completionHandler: @escaping (ServiceResponse<[GetItemsResponse]>) -> Void)
}
