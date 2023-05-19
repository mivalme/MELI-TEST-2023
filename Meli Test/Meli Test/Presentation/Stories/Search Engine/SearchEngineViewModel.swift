//
//  SearchEngineViewModel.swift
//  Meli Test
//
//  Created by Miguel Valcárcel on 17/05/23.
//

import Foundation

class SearchEngineViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var products: [Product] = []
    @Published var isLoading: Bool = false
    
    private let searchUseCase: SearchUseCaseProtocol
    
    init(searchUseCase: SearchUseCaseProtocol = SearchUseCase()) {
        self.searchUseCase = searchUseCase
    }
    
    func searchProduct() {
        isLoading = true
        products = []
        searchUseCase.getProducts(request: GetProductsRequest(query: searchText)) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let data):
                self.products = data.results
            default:
                break
            }
            self.isLoading = false
        }
    }
}
