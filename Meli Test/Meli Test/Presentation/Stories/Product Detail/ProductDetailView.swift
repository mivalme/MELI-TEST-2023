//
//  ProductDetailView.swift
//  Meli Test
//
//  Created by Miguel Valcárcel on 18/05/23.
//

import SwiftUI
import Kingfisher

struct ProductDetailView: View {
    @StateObject var viewModel: ProductDetailViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(viewModel.product?.condition?.title ?? String())
                    .foregroundColor(.gray)
                
                Text(viewModel.product?.title ?? String())
                    .foregroundColor(.black)
                
                TabView {
                    ForEach(viewModel.product?.pictures ?? [], id: \.id) { picture in
                        KFImage(URL(string: picture.url))
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                            .aspectRatio(1, contentMode: .fit)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .frame(maxWidth: .infinity)
                .aspectRatio(1, contentMode: .fit)
                
                VStack(alignment: .leading, spacing: 12) {
                    VStack {
                        Text(String(format: MeliLocalizables.productPrice,
                                    arguments: [viewModel.product?.price.withFormat ?? String()]))
                            .foregroundColor(.black)
                            .font(.title)
                    }
                    
                    VStack(alignment: .leading) {
                        if let acceptsMercadopago = viewModel.product?.acceptsMercadopago, acceptsMercadopago {
                            Text(MeliLocalizables.mercadopagoMessage)
                                .foregroundColor(MeliColorScheme.blue)
                        }
                        
                        if let freeShipping = viewModel.product?.shipping?.freeShipping, freeShipping {
                            Text(MeliLocalizables.freeShippingMessage)
                                .foregroundColor(MeliColorScheme.success)
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Text(String(format: MeliLocalizables.soldQuantityMessage,
                                    arguments: [viewModel.product?.soldQuantity ?? 0]))
                            .foregroundColor(.gray)
                            .font(.caption)
                        
                        Text(String(format: MeliLocalizables.availableQuantityMessage,
                                    arguments: [viewModel.product?.availableQuantity ?? 0]))
                            .foregroundColor(.black)
                            .font(.body)
                    }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        ForEach(viewModel.product?.attributes ?? [], id: \.id) { attribute in
                            HStack {
                                Text(attribute.name)
                                    .foregroundColor(.black)
                                    .font(.subheadline)
                                
                                Text(attribute.valueName ?? String())
                                    .foregroundColor(.gray)
                                    .font(.body)
                            }
                        }
                    }
                }
                
                Spacer()
            }
            .padding(16)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toast(config: viewModel.toastConfig, isShowing: $viewModel.showToast)
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(viewModel: .init(productId: "MCO1147430217"))
    }
}
