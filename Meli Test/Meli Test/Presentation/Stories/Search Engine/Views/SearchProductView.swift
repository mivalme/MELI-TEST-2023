//
//  SearchProductView.swift
//  Meli Test
//
//  Created by Miguel Valcárcel on 18/05/23.
//

import SwiftUI
import Kingfisher

struct SearchProductView: View {
    let product: Product
    
    var body: some View {
        HStack(spacing: 16) {
            KFImage(URL(string: String(format: MeliLocalizables.imageUrl,
                                       arguments: [product.thumbnailId])))
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                
            
            VStack(alignment: .leading, spacing: 8) {
                Text(product.title)
                    .foregroundColor(.black)
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)
                
                Text(String(format: MeliLocalizables.productPrice,
                            arguments: [product.price.withFormat]))
                    .foregroundColor(.black)
                    .font(.title)
                
                if let installments = product.installments {
                    Text(String(format: MeliLocalizables.installmentsInfo,
                                arguments: [installments.quantity,
                                            Int(installments.amount).withFormat,
                                            installments.rate == 0 ? MeliLocalizables.noInterestMessage : String()]))
                        .foregroundColor(installments.rate == 0 ? MeliColorScheme.success : .black)
                        .multilineTextAlignment(.leading)
                }
            }
            
            Spacer()
        }
        .padding(12)
        .background(.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.11), radius: 26, x: 4, y: 4)
    }
}

struct SearchProductView_Previews: PreviewProvider {
    static var previews: some View {
        SearchProductView(product: .init(id: "",
                                         title: "Test product",
                                         thumbnailId: "714411-MLA52696806401_122022",
                                         price: 549990,
                                         installments: .init(quantity: 36,
                                                             amount: 45413.89,
                                                             rate: 0)))
    }
}
