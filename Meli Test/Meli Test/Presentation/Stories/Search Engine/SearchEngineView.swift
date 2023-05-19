//
//  SearchEngineView.swift
//  Meli Test
//
//  Created by Miguel Valcárcel on 17/05/23.
//

import SwiftUI

struct SearchEngineView: View {
    @StateObject var viewModel = SearchEngineViewModel()
    @State var showCategoryIndicator: Bool = false
    @State var categoryName: String = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                VStack {
                    TextField("Ej. Play Station 5", text: $viewModel.searchText, onCommit: { viewModel.searchProduct() })
                        .padding(8)
                        .background(Color.white)
                        .cornerRadius(8)
                }
                .padding(16)
                .background(Color("primary-light"))
                
                if showCategoryIndicator {
                    VStack {
                        HStack {
                            Text(categoryName)
                                .foregroundColor(.white)
                            
                            Image(systemName: "xmark.circle.fill")
                        }
                        .padding(8)
                        .background(Color.gray)
                        .cornerRadius(8)
                        .onTapGesture {
                            showCategoryIndicator = false
                            viewModel.products = []
                        }
                    }
                    .padding(12)
                }
                
                ZStack {
                    if viewModel.isLoading {
                        loaderView
                    } else {
                        
                        if viewModel.products.isEmpty {
                            VStack {
                                Text("Usa la barra de arriba para buscar un producto, o selecciona una categoría.")
                                    .foregroundColor(.gray)
                                    .font(.title3)
                                    .padding(12)
                                
                                ScrollView {
                                    VStack(spacing: 12) {
                                        ForEach(viewModel.categories, id: \.id) { category in
                                            ProductCategoryView(category: category)
                                                .onTapGesture {
                                                    viewModel.searchProduct(categoryId: category.id)
                                                    showCategoryIndicator = true
                                                    categoryName = category.name
                                                }
                                        }
                                    }
                                    .padding(12)
                                }
                            }
                        } else {
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
                }
                
            }
            .navigationTitle("Buscar")
            .navigationBarHidden(true)
        }
    }
    
    private var loaderView: some View {
        VStack {
            Spacer()
            
            LottieView(animation: "yellow-loader", loopMode: .loop)
                .frame(width: 150, height: 150)
            
            Spacer()
        }
    }
}

struct SearchEngineView_Previews: PreviewProvider {
    static var previews: some View {
        SearchEngineView()
    }
}
