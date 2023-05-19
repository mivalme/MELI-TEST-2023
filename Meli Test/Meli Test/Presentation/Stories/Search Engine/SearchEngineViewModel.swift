//
//  SearchEngineViewModel.swift
//  Meli Test
//
//  Created by Miguel Valcárcel on 17/05/23.
//

import Foundation

class SearchEngineViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var categories: [ProductCategory] = []
    @Published var products: [Product] = []
    @Published var isLoading: Bool = false
    
    private let sitesUseCase: SitesUseCaseProtocol
    
    init(searchUseCase: SitesUseCaseProtocol = SitesUseCase()) {
        self.sitesUseCase = searchUseCase
        getCategories()
    }
    
    func getCategories() {
        isLoading = true
        sitesUseCase.getCategories { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let data):
                self.categories = data
            default:
                break
            }
            self.isLoading = false
        }
    }
    
    func searchProduct(categoryId: String? = nil) {
        if categoryId?.isEmpty == false {
            searchText = ""
        }
        isLoading = true
        products = []
        sitesUseCase.getProducts(request: GetProductsRequest(query: searchText,
                                                             category: categoryId)) { [weak self] response in
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
