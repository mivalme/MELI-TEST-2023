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
            KFImage(URL(string: "http://http2.mlstatic.com/D_\(product.thumbnailId)-O.jpg"))
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                
            
            VStack(alignment: .leading, spacing: 8) {
                Text(product.title)
                    .lineLimit(3)
                
                Text("$ \(product.price)")
                    .font(.title)
                
                Text("\(product.installments.quantity)x $ \(Int(product.installments.amount)) \(product.installments.rate == 0 ? "sin interés" : "")")
                    .foregroundColor(product.installments.rate == 0 ? Color("success") : .black)
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
