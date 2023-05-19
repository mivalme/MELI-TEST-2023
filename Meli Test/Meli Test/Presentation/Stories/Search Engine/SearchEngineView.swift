//
//  SearchEngineView.swift
//  Meli Test
//
//  Created by Miguel Valcárcel on 17/05/23.
//

import SwiftUI

struct SearchEngineView: View {
    @StateObject var viewModel = SearchEngineViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                VStack {
                    TextField("Search here", text: $viewModel.searchText, onCommit: viewModel.searchProduct)
                        .padding(8)
                        .background(Color.white)
                        .cornerRadius(8)
                }
                .padding(16)
                .background(Color("primary-light"))
                
                ZStack {
                    if viewModel.isLoading {
                        loaderView
                    }
                    
                    ScrollView {
                        VStack(spacing: 12) {
                            ForEach(viewModel.products, id: \.id) { product in
                                NavigationLink(destination: ProductDetailView(viewModel: .init(productId: product.id))) {
                                    SearchProductView(product: product)
                                }
                            }
                        }
                        .padding(12)
                    }
                }
            }
            .navigationTitle("Buscar")
            .navigationBarHidden(true)
        }
    }
    
    private var loaderView: some View {
        LottieView(animation: "yellow-loader", loopMode: .loop)
            .frame(width: 150, height: 150)
    }
}

struct SearchEngineView_Previews: PreviewProvider {
    static var previews: some View {
        SearchEngineView()
    }
}
