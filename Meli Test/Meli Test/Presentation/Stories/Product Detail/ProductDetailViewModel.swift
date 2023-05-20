//
//  ProductDetailViewModel.swift
//  Meli Test
//
//  Created by Miguel Valcárcel on 18/05/23.
//

import Foundation

class ProductDetailViewModel: ObservableObject {
    @Published var product: Product?
    @Published var showToast = false
    @Published var toastConfig: Toast.Config?
    
    let productId: String
    let itemsUseCase: ItemsUseCaseProtocol
    
    init(productId: String, itemsUseCase: ItemsUseCaseProtocol = ItemsUseCase()) {
        self.productId = productId
        self.itemsUseCase = itemsUseCase
        fetchProductData()
    }
    
    func fetchProductData() {
        itemsUseCase.getItems(request: .init(ids: productId)) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let data):
                self.product = data.first?.body
            case .failure:
                self.toastConfig = .init(message: MeliLocalizables.errorDefaultMessage, type: .error)
                self.showToast = true
            case .notConnectedToInternet:
                self.toastConfig = .init(message: MeliLocalizables.noInternetConnectionMessage, type: .error)
                self.showToast = true
            }
        }
    }
}
