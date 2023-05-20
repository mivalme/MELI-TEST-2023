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
    @Published var showToast = false
    @Published var toastConfig: Toast.Config?
    
    private let sitesUseCase: SitesUseCaseProtocol
    
    init(sitesUseCase: SitesUseCaseProtocol = SitesUseCase()) {
        self.sitesUseCase = sitesUseCase
        getCategories()
    }
    
    func getCategories() {
        isLoading = true
        sitesUseCase.getCategories { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let data):
                self.categories = data
            case .failure:
                self.toastConfig = .init(message: MeliLocalizables.errorDefaultMessage, type: .error)
                self.showToast = true
            case .notConnectedToInternet:
                self.toastConfig = .init(message: MeliLocalizables.noInternetConnectionMessage, type: .error)
                self.showToast = true
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
            case .failure:
                self.toastConfig = .init(message: MeliLocalizables.errorDefaultMessage, type: .error)
                self.showToast = true
            case .notConnectedToInternet:
                self.toastConfig = .init(message: MeliLocalizables.noInternetConnectionMessage, type: .error)
                self.showToast = true
            }
            self.isLoading = false
        }
    }
}
